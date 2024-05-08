import SwiftUI

public struct TagItemBuilder {
    public let tag: AnyHashable
    public let itemBuilder: (_ isSelected: Bool) -> AnyView
}

class BuilderManager {
    static func == (lhs: BuilderManager, rhs: BuilderManager) -> Bool {
        lhs === rhs
    }

    var builders: [TagItemBuilder] = []

    init(_ builders: [TagItemBuilder] = []) {
        self.builders = builders
    }
}
