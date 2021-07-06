//
//  ContentView.swift
//  VideoTrimmingExample
//
//  Created by Maxim Krouk on 6.07.21.
//

import SwiftUIX

struct ContentView: View {
  @State var trim1: ClosedRange<Double> = 0...150
  @State var trim2: ClosedRange<Double> = 0...100
  @State var trim3: ClosedRange<Double> = 0...200
  
  var body: some View {
    VStack {
      note
      trimArea
      legend
    }
    .maxWidth(.infinity)
    .maxHeight(.infinity)
  }
  
  
  var trimArea: some View {
    GeometryReader { proxy in
      CocoaScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 0) {
          Color.clear.width(proxy.size.width / 2)
          Trimmer(
            totalValue: 150,
            scale: 1,
            coordinateSpace: .global,
            trim: $trim1
          ) {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
              .fill(LinearGradient(gradient: Gradient(
                colors: [Color.green, Color.blue]),
                startPoint: .leading,
                endPoint: .trailing
              ))
          }
          Trimmer(
            totalValue: 100,
            scale: 1,
            coordinateSpace: .global,
            trim: $trim2
          ) {
              RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(
                  colors: [Color.green, Color.blue]),
                  startPoint: .leading,
                  endPoint: .trailing
                ))
          }
          Trimmer(
            totalValue: 200,
            scale: 1,
            coordinateSpace: .global,
            trim: $trim3
          ) {
              RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(
                  colors: [Color.green, Color.blue]),
                  startPoint: .leading,
                  endPoint: .trailing
                ))
          }
          Color.clear.width(proxy.size.width / 2)
        }
        .background(Color.pink)
      }
      .alwaysBounceHorizontal(true)
      .background(Color.gray)
    }
    .frame(height: 58)
  }
  
  var note: some View {
    Text(
      """
      Trim something to see that ScrollView.body.contentSize is not updating.
      
      Also, note that the content is loading with a delay, at least on a simulator.
      Maybe you even have to tap a view to load ScrollView content.
      """
    )
      .multilineTextAlignment(.center)
      .padding(48)
  }
  
  var legend: some View {
    VStack {
      HStack(spacing: 0) {
        Text("ScrollView is ")
        Text("gray")
          .font(.system(size: 18, weight: .bold))
          .foregroundColor(.gray)
      }
      HStack(spacing: 0) {
        Text("ScrollView.body.HStack is ")
        Text("pink")
          .font(.system(size: 18, weight: .bold))
          .foregroundColor(.pink)
      }
      Text(
        "ScrollView.contentInsets works the same, " +
        "but you won't see stackView frame, " +
        "so I used Color.clear spacers for the example"
      )
        .multilineTextAlignment(.center)
        .padding(32)
    }
  }
}
