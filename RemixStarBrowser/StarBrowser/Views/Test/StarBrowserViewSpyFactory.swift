class StarBrowserViewSpyFactory: StarBrowserViewFactory {

    var listView = StarListViewSpy()
    var detailView = StarDetailViewSpy()

    func makeListView() -> StarListView {
        return listView
    }

    func makeDetailView() -> StarDetailView {
        return detailView
    }
}
