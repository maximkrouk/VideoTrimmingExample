import SwiftUIX

struct Knob<Content: View>: View {
  @Binding
  var value: Double
  
  var totalValue: Double
  var valueRange: ClosedRange<Double>
  var coordinateSpace: CoordinateSpace
  var content: () -> Content
  
  @State
  private var initialValue: Double?
  
  var body: some View {
    content()
      .contentShape(Rectangle())
      .gesture(dragGesture)
  }
  
  var dragGesture: some Gesture {
    DragGesture(coordinateSpace: coordinateSpace)
      .onChanged { value in
        let _initialValue: Double
        if let _value = initialValue {
          _initialValue = _value
        } else {
          _initialValue = self.value
          initialValue = _initialValue
        }
        let translation = Double(value.translation.width)
        self.value = valueRange.find(_initialValue + translation)
        print(valueRange, self.value)
      }
      .onEnded { _ in
        initialValue = nil
      }
  }
}


struct Trimmer<Content: View>: View {
  /// Total value to trim
  var totalValue: Double
  
  /// Represents relation between pixels (points) and value
  ///
  /// scale = width / value
  var scale: Double
  
  /// Coordinate space for drag gestures
  var coordinateSpace: CoordinateSpace
  
  /// Trim for total value
  ///
  /// Trimmed value is equal to trim.length
  /// trim.length = trim.upperBound - trim.lowerBound
  @Binding
  var trim: ClosedRange<Double>
  
  var content: () -> Content
  
  var body: some View {
    content()
      .overlay(
        Color.clear
          .overlay(
            leadingKnob,
            alignment: .leading
          )
          .overlay(
            trailingKnob,
            alignment: .trailing
          )
      )
      .frame(width: CGFloat(trim.length * scale))
  }
  
  var leadingKnob: some View {
    Knob(
      value: $trim.map(
        get: { $0.lowerBound },
        set: { $0 = $1...$0.upperBound }
      ),
      totalValue: totalValue,
      valueRange: 0...trim.upperBound,
      coordinateSpace: coordinateSpace
    ) {
      RoundedRectangle(cornerRadius: 4)
        .fill(Color.yellow)
        .overlay(
          Image(systemName: "chevron.left")
            .font(.headline)
            .foregroundColor(.black)
            .allowsHitTesting(false)
            .scaleEffect(y: 1.6)
        )
    }
    .padding([.top, .bottom], 8)
    .frame(width: 16)
  }
  
  var trailingKnob: some View {
    Knob(
      value: $trim.map(
        get: { $0.upperBound },
        set: { $0 = $0.lowerBound...$1 }
      ),
      totalValue: totalValue,
      valueRange: trim.lowerBound...totalValue,
      coordinateSpace: coordinateSpace
    ) {
      RoundedRectangle(cornerRadius: 4)
        .fill(Color.yellow)
        .overlay(
          Image(systemName: "chevron.right")
            .font(.headline)
            .foregroundColor(.black)
            .allowsHitTesting(false)
            .scaleEffect(y: 1.6)
        )
    }
    .padding([.top, .bottom], 8)
    .frame(width: 16)
  }
}
