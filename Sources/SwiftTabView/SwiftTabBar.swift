import SwiftUI

public protocol SwiftTabBarStyle {
    associatedtype TabBarView: View

    @ViewBuilder @MainActor
    func tabBar(tabItems: [(AnyHashable, (_ isSelected: Bool) -> AnyView)]) -> Self.TabBarView
}

public struct SwiftTabBar<Style: SwiftTabBarStyle>: View {
    let style: Style

    public init(style: Style) {
        self.style = style
    }

    public var body: some View {
        EmptyView()
//        if let manager = managerStack.last {
//            let _ = print("SwiftTabBar body:", manager.builders)
//            style.tabBar(tabItems: manager.builders)
//        }
    }
}
