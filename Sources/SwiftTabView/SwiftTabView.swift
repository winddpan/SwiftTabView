import SwiftUI

public struct SwiftTabView<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    private let selection: Binding<SelectionValue>?
    private let content: () -> Content

    public init(selection: Binding<SelectionValue>?,
                @ViewBuilder content: @escaping () -> Content) {
        self.selection = selection
        self.content = content
    }

    public var body: some View {
        _VariadicView.Tree(TabLayout(selection: selection), content: content)
    }
}

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
