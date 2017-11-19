class StarBrowserViewDoubleFactory: StarBrowserViewFactory {

    let list = StarListViewSpy()
    let loading = StarLoadingViewSpy()
    let error = StarErrorViewSpy()
    let detail = StarDetailViewSpy()

    func makeListView() -> StarListView {
        return list
    }

    func makeLoadingView() -> StarLoadingView {
        return loading
    }

    func makeErrorView() -> StarErrorView {
        return error
    }

    func makeDetailView() -> StarDetailView {
        return detail
    }
}

protocol ScreenNameable {
    var screenName: String { get }
}
