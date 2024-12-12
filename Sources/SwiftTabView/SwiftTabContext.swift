import Combine
import Foundation
import SwiftUI

class SelectionObservable: ObservableObject {
    @Published var selection: AnyHashable = .init(Int.min)
}

public struct SwiftTabContext {
    let selectionObservable = SelectionObservable()
    var builderManager: BuilderManager?

    public init() {}
}
