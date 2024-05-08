import SwiftUI

public extension View {
    func swiftTabItem(tag: some Hashable, @ViewBuilder _ label: @escaping (_ isSelected: Bool) -> some View) -> some View {
        if let manager = refBuilderManager {
            let builder = { isSelected in
                AnyView(label(isSelected))
            }
            manager.builders.append(TagItemBuilder(tag: tag, itemBuilder: builder))
        }

        return id(tag)
    }
}
