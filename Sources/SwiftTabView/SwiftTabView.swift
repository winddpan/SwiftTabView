import SwiftUI

private(set) var refBuilderManager: BuilderManager?

public struct SwiftTabView<SelectionValue: Hashable, Content: View>: View {
    @ObservedObject var selectionObservable: SelectionObservable
    @Binding private var context: SwiftTabContext
    private let selection: Binding<SelectionValue>?
    private let content: () -> Content

    public init(selection: Binding<SelectionValue>?,
                context: Binding<SwiftTabContext>,
                @ViewBuilder content: @escaping () -> Content) {
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

        _VariadicView.Tree(TabLayout(selection: $selectionObservable.selection), content: content)
            .onAppear {
                context.builderManager = toBindBuilderManager
                if let selection, selectionObservable.selection != AnyHashable(selection.wrappedValue) {
                    selectionObservable.selection = AnyHashable(selection.wrappedValue)
                }
            }
            .onChange(of: selection?.wrappedValue) { newValue in
                if let newValue {
                    selectionObservable.selection = newValue
                }
            }

        let _ = {
            refBuilderManager = nil
        }()
    }
}

public extension SwiftTabView where SelectionValue == AnyHashable {
    init(context: Binding<SwiftTabContext>,
         @ViewBuilder content: @escaping () -> Content) {
        self.init(selection: nil, context: context, content: content)
    }
}

private struct TabLayout: _VariadicView_MultiViewRoot {
    let selection: Binding<AnyHashable>

    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        TabHosting(selection: selection, children: children)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}
