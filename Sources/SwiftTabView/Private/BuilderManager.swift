import SwiftUI

public struct TagItemBuilder {
    public let tag: AnyHashable
    public let tabBuilder: (_ isSelected: Bool) -> AnyView
    let contentBuilder: () -> AnyView
    
    init(tag: AnyHashable, tabBuilder: @escaping (_: Bool) -> AnyView, contentBuilder: @escaping () -> AnyView) {
        self.tag = tag
        self.tabBuilder = tabBuilder
        self.contentBuilder = contentBuilder
    }
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
