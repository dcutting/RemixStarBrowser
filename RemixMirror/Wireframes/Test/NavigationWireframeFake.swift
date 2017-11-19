extension Navigatable {

    func isOnTop(of wireframe: NavigationWireframeFake) -> Bool {
        return wireframe.top === self
    }
}

class NavigationWireframeFake: NavigationWireframe {

    var navigatables = [Navigatable]()

    func push(_ navigatable: Navigatable) {
        navigatables.append(navigatable)
    }

    func pop() {
        _ = navigatables.popLast()
    }

    var topScreenName: String? {
        let screenNameable = navigatables.last as? ScreenNameable
        return screenNameable?.screenName
    }

    var top: Navigatable? {
        return navigatables.last
    }
}
