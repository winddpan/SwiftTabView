//
//  TestViews.swift
//  Example
//
//  Created by wp on 2024/5/8.
//

import SwiftUI

struct TabItemView: View {
    let name: String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: "scribble")
                .font(.system(size: 24))
                .foregroundStyle(isSelected ? Color.accentColor : Color.gray)
                .padding(.top, 8)
            Text(name)
                .font(.system(size: 10))
                .foregroundStyle(isSelected ? Color.accentColor : Color.gray)
        }
        .frame(width: 60)
    }
}

struct UUIDTestView: View {
    @State var string: String = UUID().uuidString

    var body: some View {
        Text(string)
            .onTapGesture {
                string = UUID().uuidString
            }
            .onAppear(perform: {
                print("onAppear:", string)
            })
    }
}
