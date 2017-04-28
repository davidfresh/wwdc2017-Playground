import Foundation

func argmax<T, U: Comparable>(_ elements: [(T, U)]) -> T? {
    if let start = elements.first {
        return elements.reduce(start) { $0.1 > $1.1 ? $0 : $1 }.0
    }
    return nil
}
