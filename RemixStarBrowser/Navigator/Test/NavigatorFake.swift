class NavigatorFake: Navigator {

    var navigatables = [Navigatable]()
    var presented: Navigatable?

    func push(_ navigatable: Navigatable) {
        navigatables.append(navigatable)
    }

    func pop() {
        _ = navigatables.popLast()
    }

    func present(_ navigatable: Navigatable, completion: (() -> Void)?) {
        presented = navigatable
        completion?()
    }

    func dismiss(completion: (() -> Void)?) {
        presented = nil
        completion?()
    }

    var visible: Navigatable? {
        return presented ?? navigatables.last
    }
}
