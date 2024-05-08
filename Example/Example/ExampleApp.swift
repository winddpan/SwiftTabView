import SwiftUI

@main
struct ExampleApp: App {
    @State var sheet1 = false
    @State var sheet2 = false

    var body: some Scene {
        WindowGroup {
            List {
                Button("System Style") {
                    sheet1 = true
                }
                .sheet(isPresented: $sheet1, content: {
                    SystemStyleView()
                })

                Button("HideBottomWhenPushed") {
                    sheet2 = true
                }
                .sheet(isPresented: $sheet2, content: {
                    HideBottomWhenPushedView()
                })
            }
        }
    }
}
