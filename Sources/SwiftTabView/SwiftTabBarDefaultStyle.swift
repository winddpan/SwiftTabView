import SwiftUI

// public struct SwiftTabBar<SelectionValue: Hashable, Content: View>: View {
//    let id: SelectionValue
//    let content: (SelectionValue, Bool) -> Content
//
//    public init(id: SelectionValue,
//                @ViewBuilder content: @escaping (SelectionValue, Bool) -> Content) {
//        self.id = id
//        self.content = content
//    }
//
//    public var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
// }
//
// public extension View {
//    @ViewBuilder func swiftTabBar<SelectionValue: Hashable>(_ selection: Binding<SelectionValue>) -> some View {
//        Text("123")
//    }
// }
//
//// #Preview {
////    SwiftTabBar<String>()
//// }

struct SwiftTabItemDefaultStyle<SelectionValue: Hashable>: SwiftTabItemStyle {
    init(_ type: SelectionValue.Type) {}

    func tabItem(id: SelectionValue, isSelected: Bool) -> some View {
        VStack(spacing: 0) {
            (isSelected ? selectedIcon : icon)
                .renderingMode(.template)
                .font(.system(size: 19))
                .frame(height: 30)
                .padding(.top, 8)
            title
                .font(.system(size: 10.0, weight: .medium))
        }
        .frame(width: 60)
        .frame(height: 49)
        .contentShape(Rectangle())
        .foregroundColor(isSelected ? .accentColor : .systemTextColor.opacity(0.5))
    }
}

struct SwiftTabBarDefaultStyle: SwiftTabBarStyle {
    func tabBar(tabItems: AnyView) -> some View {
        VStack(spacing: 0.0) {
            VStack {
                HStack {
                    tabItems
                }
                .frame(height: 50.0)
                //                .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
//            .frame(height: 50.0 + geometry.safeAreaInsets.bottom)
        }
    }
}
