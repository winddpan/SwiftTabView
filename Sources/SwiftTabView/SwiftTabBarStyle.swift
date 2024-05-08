import SwiftUI

public protocol SwiftTabBarStyle {
    associatedtype TabBarView: View

    @ViewBuilder @MainActor
    func tabBar(selection: Binding<AnyHashable>, tabItemsBuilders: [TagItemBuilder]) -> Self.TabBarView
}
