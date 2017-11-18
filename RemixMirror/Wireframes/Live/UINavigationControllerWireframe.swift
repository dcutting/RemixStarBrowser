import UIKit

extension Navigatable {

    var viewController: UIViewController? {
        return self as? UIViewController
    }
}

class UINavigationControllerWireframe: UINavigationController, NavigationWireframe {

    func push(_ navigatable: Navigatable) {
        guard let viewController = navigatable.viewController else { return }
        pushViewController(viewController, animated: true)
    }

    func pop() {
        popViewController(animated: true)
    }
}
