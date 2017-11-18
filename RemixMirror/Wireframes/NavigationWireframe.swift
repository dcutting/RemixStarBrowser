protocol Navigatable: class {}

protocol NavigationWireframe {
    func push(_ navigatable: Navigatable)
    func pop()
}
