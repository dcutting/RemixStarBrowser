protocol StarLoadingView: Navigatable {
}

protocol StarLoadingViewFactory: class {
    func make() -> StarLoadingView
}
