import Combine
import SwiftUI
import UIKit

struct TabHosting: UIViewControllerRepresentable {
    let selection: Binding<AnyHashable>
    let builderManager: BuilderManager

    func makeUIViewController(context: Context) -> TabHostingViewController {
        TabHostingViewController()
    }

    func updateUIViewController(_ uiViewController: TabHostingViewController, context: Context) {
        uiViewController.builders = builderManager.builders
        uiViewController.selected = selection.wrappedValue
    }
}

class TabHostingViewController: UIViewController {
    private var loadChilds: [AnyHashable: UIHostingController<AnyView>] = [:]

    var builders: [TagItemBuilder] = [] {
        didSet {
            if builders.map(\.tag) != oldValue.map(\.tag) {
                rebuild()
            }
        }
    }

    var selected: AnyHashable? {
        didSet {
            if oldValue != selected, let selected {
                loadChild(selected)
            }
        }
    }

    private func rebuild() {
        children.forEach {
            $0.viewIfLoaded?.removeFromSuperview()
            $0.removeFromParent()
        }
        loadChilds.removeAll()
    }

    func loadChild(_ selected: AnyHashable) {
        guard let contentBuilder = builders.first(where: { $0.tag == selected })?.contentBuilder else {
            return
        }

        let firstAdd = loadChilds[selected] == nil
        let viewController = loadChilds[selected] ?? UIHostingController(rootView: contentBuilder())

        loadChilds.forEach { key, vc in
            if key != selected {
                vc.view.removeFromSuperview()
                vc.removeFromParent()
            }
        }

        if firstAdd {
            addChild(viewController)
        }
        if viewController.view.superview == nil {
            view.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        if firstAdd {
            viewController.didMove(toParent: self)
        }

        loadChilds[selected] = viewController
    }
}
