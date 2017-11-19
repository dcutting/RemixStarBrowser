class StarBrowserViewDoubleFactory: StarBrowserViewFactory {

    let listView: StarListViewSpy
    let loadingView: StarLoadingViewSpy
    let errorView: StarErrorViewSpy
    let detailView: StarDetailViewSpy

    init(listView: StarListViewSpy = StarListViewSpy(),
         loadingView: StarLoadingViewSpy = StarLoadingViewSpy(),
         errorView: StarErrorViewSpy = StarErrorViewSpy(),
         detailView: StarDetailViewSpy = StarDetailViewSpy()) {

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

protocol ScreenNameable {
    var screenName: String { get }
}
