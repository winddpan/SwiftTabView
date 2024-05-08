import SwiftUI

public struct SwiftTabBar<Style: SwiftTabBarStyle>: View {
    @Binding var context: SwiftTabContext
    @ObservedObject var selectionObservable: SelectionObservable
    let style: Style

    public init(style: Style, context: Binding<SwiftTabContext>) {
        self.style = style
        _context = context
        _selectionObservable = .init(initialValue: context.wrappedValue.selectionObservable)
    }

    public var body: some View {
        if let manager = context.builderManager {
            style.tabBar(selection: $selectionObservable.selection, tabItemsBuilders: manager.builders)
        }
    }
}
