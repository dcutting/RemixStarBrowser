import UIKit

extension Navigatable {

    var viewController: UIViewController? {
        return self as? UIViewController
    }
}

class UINavigationControllerWireframe: UINavigationController, NavigationWireframe {

    func push(_ navigatable: Navigatable) {
        guard let viewController = navigatable.viewController else { return }
        onMainQueue {
            self.pushViewController(viewController, animated: true)
        }
    }

    func pop() {
        onMainQueue {
            self.popViewController(animated: true)
        }
    }

    func present(_ navigatable: Navigatable, completion: (() -> Void)?) {
        guard let viewController = navigatable.viewController else { return }
        onMainQueue {
            self.present(viewController, animated: true, completion: completion)
        }
    }

    func dismiss(completion: (() -> Void)?) {
        onMainQueue {
            self.dismiss(animated: true, completion: completion)
        }
    }

    private func onMainQueue(block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
}
