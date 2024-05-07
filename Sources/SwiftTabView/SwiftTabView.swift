import SwiftUI

public struct SwiftTabView<SelectionValue: Hashable, Content: View>: View {
    private let builderManager = BuilderManager()
    private let selection: Binding<SelectionValue>?
    private let content: () -> Content
    private let postContent: ((any View) -> any View)?

    public init(selection: Binding<SelectionValue>?,
                @ViewBuilder content: @escaping () -> Content,
                postContent: ((some View) -> any View)? = nil) {
        self.selection = selection
        self.content = content
        self.postContent = postContent
    }

    public var body: some View {
        let view = _VariadicView.Tree(TabLayout(selection: selection), content: content)
        if let postContent {
            postContent(view)
//                .environment(\.builderManager, builderManager)
        } else {
            view
                .environment(\.builderManager, builderManager)
        }
    }
}

// public extension SwiftTabView where PostContentOut == Content {
//    init(selection: Binding<SelectionValue>?,
//         @ViewBuilder content: @escaping () -> Content) {
//        self.selection = selection
//        self.content = content
//        postContent = { $0 }
//    }
// }

private struct TabLayout<SelectionValue>: _VariadicView_MultiViewRoot where SelectionValue: Hashable {
    let selection: Binding<SelectionValue>?

    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        let binding = Binding<AnyHashable>.init(get: {
            if let value = selection?.wrappedValue as? AnyHashable {
                return value
            }
            return children.first!.id
        }, set: {
            if let value = $0 as? SelectionValue {
                selection?.wrappedValue = value
            }
        })

        TabHosting(selection: binding, children: children)
    }
}
