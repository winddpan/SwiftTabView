import SwiftUI

private(set) var refBuilderManager: BuilderManager?

public struct SwiftTabView<SelectionValue: Hashable, Content: View>: View {
    @ObservedObject var selectionObservable: SelectionObservable
    @Binding private var context: SwiftTabContext
    private let selection: Binding<SelectionValue>?
    private let content: () -> Content

    public init(
        selection: Binding<SelectionValue>?,
        context: Binding<SwiftTabContext>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        _context = context
        self.content = content
        _selectionObservable = .init(initialValue: context.wrappedValue.selectionObservable)
    }

    public var body: some View {
        let _ = {
            refBuilderManager = BuilderManager()
        }()

        let toBindBuilderManager = refBuilderManager

        _VariadicView.Tree(
            TabLayout(selection: $selectionObservable.selection, builderManager: toBindBuilderManager!),
            content: content
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .onAppear {
            context.builderManager = toBindBuilderManager
            if let selection, selectionObservable.selection != AnyHashable(selection.wrappedValue) {
                selectionObservable.selection = selection.wrappedValue
            }
        }
        .onChange(of: selection?.wrappedValue) { newValue in
            if let newValue, selectionObservable.selection != AnyHashable(newValue) {
                selectionObservable.selection = newValue
            }
        }
        .onReceive(selectionObservable.$selection) { newValue in
            if let newValue = newValue as? SelectionValue, selection?.wrappedValue != newValue {
                selection?.wrappedValue = newValue
            }
        }

        let _ = {
            refBuilderManager = nil
        }()
    }
}

extension SwiftTabView where SelectionValue == AnyHashable {
    public init(
        context: Binding<SwiftTabContext>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(selection: nil, context: context, content: content)
    }
}

private struct TabLayout: _VariadicView_MultiViewRoot {
    let selection: Binding<AnyHashable>
    let builderManager: BuilderManager

    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        TabHosting(selection: selection, builderManager: builderManager)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}
