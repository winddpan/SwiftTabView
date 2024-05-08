import SwiftUI

public extension View {
    func swiftTabItem(tag: some Hashable, @ViewBuilder _ label: @escaping (_ isSelected: Bool) -> some View) -> some View {
        id(tag)
            .modifier(SwiftTabItemModifier(tagId: tag, label: label))
    }
}

struct SwiftTabItemModifier<TagID: Hashable, Label: View>: ViewModifier {
    let tagId: TagID
    let label: (_ isSelected: Bool) -> Label

    init(tagId: TagID, label: @escaping (_ isSelected: Bool) -> Label) {
        self.tagId = tagId
        self.label = label
        tryAppendBuilder()
    }

    private func tryAppendBuilder() {
        if let manager = refBuilderManager {
            let builder = { isSelected in
                AnyView(label(isSelected))
            }
            manager.builders.append(TagItemBuilder(tag: tagId, itemBuilder: builder))
        }
    }

    func body(content: Content) -> some View {
        content
    }
}
