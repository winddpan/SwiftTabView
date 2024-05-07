import Combine
import SwiftUI
import UIKit

struct TabHosting: UIViewControllerRepresentable {
    let selection: Binding<AnyHashable>?
    let children: _VariadicView.Children

    func makeUIViewController(context: Context) -> TabHostingViewController {
        TabHostingViewController()
    }

    func updateUIViewController(_ uiViewController: TabHostingViewController, context: Context) {
        if let selection = selection?.wrappedValue {
            uiViewController.selectionSubject.value = selection
        }
        uiViewController.childrenViews = children
    }
}

class TabHostingViewController: UIViewController {
    var cancellable = Set<AnyCancellable>()
    let selection: Binding<AnyHashable>? = nil
    var loadChilds: [AnyHashable: UIViewController] = [:]

    let selectionSubject = CurrentValueSubject<AnyHashable?, Never>(nil)

    var childrenViews: _VariadicView.Children? {
        didSet {
            if childrenViews?.map(\.id) != oldValue?.map(\.id) {
                rebuild()
            }
        }
    }

    deinit {
        print("TabHostingViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        selectionSubject
            .eraseToAnyPublisher()
            .sink { [weak self] selection in
                guard let self else { return }
                let child = childrenViews?.first(where: { $0.id == selection }) ?? childrenViews?.first
                if let selection, let child {
                    loadChild(child)
                    if selection != self.selection?.wrappedValue {
                        self.selection?.wrappedValue = selection
                    }
                }
            }
            .store(in: &cancellable)

        rebuild()
    }

    func rebuild() {
        children.forEach {
            $0.viewIfLoaded?.removeFromSuperview()
            $0.removeFromParent()
        }
        loadChilds.removeAll()

        let value = selectionSubject.value
        selectionSubject.value = value
    }

    func loadChild(_ child: _VariadicView.Children.Element) {
        let selection = child.id
        let firstAdd = loadChilds[selection] == nil
        let viewController = loadChilds[selection] ?? UIHostingController(rootView: child)

        loadChilds.forEach { key, vc in
            if key != selection {
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

        loadChilds[selection] = viewController
    }
}
