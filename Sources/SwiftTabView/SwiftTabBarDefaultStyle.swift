import SwiftUI

public struct SwiftTabBarDefaultStyle: SwiftTabBarStyle {
    public init() {}

    public func tabBar(tabItems: [(AnyHashable, (_ isSelected: Bool) -> AnyView)]) -> some View {
        VStack(spacing: 0.0) {
            VStack {
                HStack {
                    ForEach(tabItems, id: \.0) {
                        $0.1(false)
                    }
                }
                .frame(height: 50.0)
                .background(Color.green)
                //                .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
//            .frame(height: 50.0 + geometry.safeAreaInsets.bottom)
        }
    }
}
