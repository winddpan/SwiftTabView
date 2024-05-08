//
//  HideBottomWhenPushedView.swift
//  Example
//
//  Created by wp on 2024/5/8.
//

import SwiftTabView
import SwiftUI

struct HideBottomWhenPushedView: View {
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
                .safeAreaInset(edge: .bottom) {
                    SwiftTabBar(style: DefaultSwiftTabBarStyle(), context: $tabContext)
                }
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
                    SwiftTabBar(style: DefaultSwiftTabBarStyle(), context: $tabContext)
                }
            }
            .swiftTabItem(tag: "2") { isSelected in
                TabItemView(name: "TAB2", isSelected: isSelected)
            }

            NavigationStack {
                UUIDTestView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .safeAreaInset(edge: .bottom) {
                        SwiftTabBar(style: DefaultSwiftTabBarStyle(), context: $tabContext)
                    }
            }
            .swiftTabItem(tag: "3") { isSelected in
                TabItemView(name: "TAB3", isSelected: isSelected)
            }
        }
    }
}

#Preview {
    HideBottomWhenPushedView()
}
