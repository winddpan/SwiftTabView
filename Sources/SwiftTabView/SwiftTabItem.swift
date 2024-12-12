import SwiftUI

extension View {
    public func swiftTabItem(tag: some Hashable, @ViewBuilder _ label: @escaping (_ isSelected: Bool) -> some View) -> some View {
        if let manager = refBuilderManager {
            let tabBuilder = { isSelected in
                AnyView(label(isSelected))
            }
            let contentBuilder = {
                AnyView(self)
            }
            manager.builders.append(TagItemBuilder(tag: tag, tabBuilder: tabBuilder, contentBuilder: contentBuilder))
        }

        return EmptyView()
    }
}
