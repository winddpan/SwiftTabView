import SwiftUI

public protocol SwiftTabItemStyle {
    associatedtype SelectionValue: Hashable
    associatedtype TabItem: View

    @ViewBuilder @MainActor
    func tabItem(id: SelectionValue, isSelected: Bool) -> Self.TabItem
}

public protocol SwiftTabBarStyle {
    associatedtype TabBarView: View

    @ViewBuilder @MainActor
    func tabBar(tabItems: AnyView) -> Self.TabBarView
}
