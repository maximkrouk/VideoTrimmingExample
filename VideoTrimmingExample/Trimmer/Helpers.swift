import SwiftUI

extension ClosedRange where Bound: FloatingPoint {
  public var length: Bound { upperBound - lowerBound }
}

extension ClosedRange where Bound: BinaryInteger {
  public var length: Bound { upperBound - lowerBound }
}

extension ClosedRange {
  public func find(_ value: Bound) -> Bound {
    if value < lowerBound {
      return lowerBound
    } else if value > upperBound {
      return upperBound
    } else {
      return value
    }
  }
}

extension Binding {
  @inlinable
  public func map<LocalValue>(
    get: @escaping (Value) -> LocalValue,
    set: @escaping (inout Value, LocalValue) -> Void
  ) -> Binding<LocalValue> {
    Binding<LocalValue>(
      get: { get(wrappedValue) },
      set: {
        var value = wrappedValue
        set(&value, $0)
        wrappedValue = value
      }
    )
  }
  
  @inlinable
  public func map<LocalValue>(
    _ keyPath: WritableKeyPath<Value, LocalValue>
  ) -> Binding<LocalValue> {
    map(
      get: { $0[keyPath: keyPath] },
      set: { value, localValue in
        value[keyPath: keyPath] = localValue
      }
    )
  }
}
