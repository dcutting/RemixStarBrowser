class StarBrowserViewDoubleFactory: StarBrowserViewFactory {

    private let listView: StarListView
    private let loadingView: StarLoadingView
    private let errorView: StarErrorView
    private let detailView: StarDetailView

    init(listView: StarListView = StarListViewSpy(),
         loadingView: StarLoadingView = StarLoadingViewSpy(),
         errorView: StarErrorView = StarErrorViewSpy(),
         detailView: StarDetailView = StarDetailViewSpy()) {

        self.listView = listView
        self.loadingView = loadingView
        self.errorView = errorView
        self.detailView = detailView
    }

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
