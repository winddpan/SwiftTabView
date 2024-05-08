import SwiftUI

public struct DefaultSwiftTabBarStyle: SwiftTabBarStyle {
    public init() {}

    public func tabBar(selection: Binding<AnyHashable>, tabItemsBuilders: [TagItemBuilder]) -> some View {
        HStack {
            Spacer()
            ForEach(tabItemsBuilders, id: \.tag) { item in
                item.itemBuilder(selection.wrappedValue == item.tag)
                    .onTapGesture {
                        selection.wrappedValue = item.tag
                    }
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        .frame(height: 49)
        .background(
            VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
                .ignoresSafeArea()
        )
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}
