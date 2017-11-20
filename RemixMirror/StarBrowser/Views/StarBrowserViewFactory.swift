protocol StarBrowserViewFactory {
    func makeListView() -> StarListView
    func makeLoadingView() -> StarLoadingView
    func makeErrorView() -> StarErrorView
    func makeDetailView() -> StarDetailView
}
