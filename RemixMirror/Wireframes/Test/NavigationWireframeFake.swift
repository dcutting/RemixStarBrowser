class NavigationWireframeFake: NavigationWireframe {

    var navigatables = [Navigatable]()

    func push(_ navigatable: Navigatable) {
        navigatables.append(navigatable)
    }

    func pop() {
        _ = navigatables.popLast()
    }
}
