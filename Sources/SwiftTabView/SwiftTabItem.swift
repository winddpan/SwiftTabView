import SwiftUI

public extension View {
    func swiftTabItem(tag: some Hashable, @ViewBuilder _ label: @escaping (_ isSelected: Bool) -> some View) -> some View {
        id(tag).modifier(SwiftTabItemModifier(tagId: tag, label: label))
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
//        if managerStack.last == nil {
//            managerStack.append(.init())
//        }
//
//        if let manager = managerStack.last, !manager.builders.contains(where: { $0.0 == AnyHashable(tagId) }) {
//            let builder = { isSelected in
//                AnyView(label(isSelected))
//            }
//            manager.builders.append((tagId, builder))
//        }
    }

    func body(content: Content) -> some View {
        content
    }
}
