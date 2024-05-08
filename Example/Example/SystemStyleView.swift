import SwiftTabView
import SwiftUI

struct SystemStyleView: View {
    @State var selection: String = "2"
    @State var tabContext = SwiftTabContext()

    var body: some View {
        SwiftTabView(selection: $selection, context: $tabContext) {
            NavigationStack {
                NavigationLink {
                    Text("123")
                        .navigationTitle("123")
                } label: {
                    Color.red.overlay {
                        Text("subview")
                    }
                    .navigationTitle("root")
                }
                .ignoresSafeArea()
            }
            .swiftTabItem(tag: "1") { isSelected in
                TabItemView(name: "TAB1", isSelected: isSelected)
            }

            NavigationStack {
                List {
                    ForEach(1 ... 50, id: \.self) {
                        Text("\($0)")
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 49)
                }
            }
            .swiftTabItem(tag: "2") { isSelected in
                TabItemView(name: "TAB2", isSelected: isSelected)
            }

            NavigationStack {
                UUIDTestView()
            }
            .swiftTabItem(tag: "3") { isSelected in
                TabItemView(name: "TAB3", isSelected: isSelected)
            }
        }
        .safeAreaInset(edge: .bottom) {
            SwiftTabBar(style: DefaultSwiftTabBarStyle(), context: $tabContext)
        }
    }
}

#Preview {
    SystemStyleView()
}
