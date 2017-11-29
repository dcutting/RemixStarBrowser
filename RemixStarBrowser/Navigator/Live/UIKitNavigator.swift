import UIKit

class UIKitNavigator: UINavigationController, Navigator {

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

    func present(_ navigatable: Navigatable, completion: Callback?) {
        guard let viewController = navigatable.viewController else { return }
        onMainQueue {
            self.present(viewController, animated: true, completion: completion)
        }
    }

    func dismiss(completion: Callback?) {
        onMainQueue {
            self.dismiss(animated: true, completion: completion)
        }
    }
}

private extension Navigatable {

    var viewController: UIViewController? {
        return self as? UIViewController
    }
}
