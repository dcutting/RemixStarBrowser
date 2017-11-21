protocol Navigatable: class {}

protocol NavigationWireframe {
    func push(_ navigatable: Navigatable)
    func pop()
    func present(_ navigatable: Navigatable, completion: (() -> Void)?)
    func dismiss(completion: (() -> Void)?)
}
