class StarBrowserViewDoubleFactory: StarBrowserViewFactory {

    let listView: StarListView
    let loadingView: StarLoadingView
    let errorView: StarErrorView
    let detailView: StarDetailView

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
