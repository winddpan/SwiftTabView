import SwiftUI

private struct BuilderManagerKey: EnvironmentKey {
    static let defaultValue: BuilderManager = .init()
}

extension EnvironmentValues {
    var builderManager: BuilderManager {
        get { self[BuilderManagerKey.self] }
        set { self[BuilderManagerKey.self] = newValue }
    }
}

class BuilderManager: Equatable {
    static func == (lhs: BuilderManager, rhs: BuilderManager) -> Bool {
        lhs === rhs
    }

    var builders: [(AnyHashable, (_ isSelected: Bool) -> AnyView)] = []

    init(_ builders: [(AnyHashable, (_ isSelected: Bool) -> AnyView)] = []) {
        self.builders = builders
    }
}
