class NavigatorFake: Navigator {

    var navigatables = [Navigatable]()
    var presented: Navigatable?

    func push(_ navigatable: Navigatable) {
        navigatables.append(navigatable)
    }

    func pop() {
        _ = navigatables.popLast()
    }

    func present(_ navigatable: Navigatable, completion: Callback?) {
        presented = navigatable
        completion?()
    }

    func dismiss(completion: Callback?) {
        presented = nil
        completion?()
    }

    var visibleScreenName: String? {
        let screenNameable = visible as? ScreenNameable
        return screenNameable?.screenName
    }

    private var visible: Navigatable? {
        return presented ?? navigatables.last
    }
}
