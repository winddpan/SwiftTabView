import SwiftTabView
import SwiftUI

struct ContentView: View {
    @State var selection: String = "2"

    var body: some View {
        VStack {
            SwiftTabView(selection: $selection) {
                Group {
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
                    }
                    .swiftTabItem(tag: "1") { isSelected in
                        Text("11111")
                            .foregroundStyle(isSelected ? Color.red : Color.yellow)
                    }

                    NavigationStack {
                        ZStack {
                            Color.yellow
                            TextWrapper(name: "2")
                        }
                    }
                    .ignoresSafeArea()
                    .swiftTabItem(tag: "2") { isSelected in
                        Text("22222")
                            .foregroundStyle(isSelected ? Color.red : Color.yellow)
                    }

                    NavigationStack {
                        TextWrapper(name: "3")
                    }
                    .swiftTabItem(tag: "3") { isSelected in
                        Text("33333")
                            .foregroundStyle(isSelected ? Color.red : Color.yellow)
                    }
                }
            }
            .ignoresSafeArea()
            .safeAreaInset(edge: .bottom) {
                SwiftTabBar(style: SwiftTabBarDefaultStyle())
            }

            HStack {
                ForEach(1 ... 3, id: \.self) { i in
                    Text("\(i)")
                        .padding()
                        .background(Color.gray)
                        .onTapGesture {
                            selection = "\(i)"
                        }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct TextWrapper: View {
    let name: String
    @State var string: String = UUID().uuidString

    var body: some View {
        VStack {
            Text(name)
            Text(string)
        }
        .onTapGesture {
            string = UUID().uuidString
        }
        .onAppear(perform: {
            print("onAppear:", string)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
