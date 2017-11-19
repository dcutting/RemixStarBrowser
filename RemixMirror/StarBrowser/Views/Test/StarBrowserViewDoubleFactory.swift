class StarBrowserViewDoubleFactory: StarBrowserViewFactory {

    var listView = StarListViewSpy()
    var loadingView = StarLoadingViewSpy()
    var errorView = StarErrorViewSpy()
    var detailView = StarDetailViewSpy()

    func makeListView() -> StarListView {
        return listView
    }

    func makeLoadingView() -> StarLoadingView {
        return loadingView
    }

    func makeErrorView() -> StarErrorView {
        return errorView
    }

    func makeDetailView() -> StarDetailView {
        return detailView
    }
}
