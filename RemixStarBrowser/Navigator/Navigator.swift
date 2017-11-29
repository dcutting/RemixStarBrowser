protocol Navigatable: class {}

protocol Navigator {
    func push(_ navigatable: Navigatable)
    func pop()
    func present(_ navigatable: Navigatable, completion: Callback?)
    func dismiss(completion: Callback?)
}
