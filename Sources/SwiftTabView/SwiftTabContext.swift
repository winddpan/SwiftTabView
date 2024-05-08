import Combine
import Foundation
import SwiftUI

class SelectionObservable: ObservableObject {
    @Published var selection: AnyHashable = .init(0)
}

public struct SwiftTabContext {
    let selectionObservable = SelectionObservable()
    var builderManager: BuilderManager?

    public init() {}
}
