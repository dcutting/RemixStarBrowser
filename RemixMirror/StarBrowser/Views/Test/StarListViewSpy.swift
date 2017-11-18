class StarListViewDoubleFactory: StarListViewFactory {

    var view = StarListViewSpy()

    func make() -> StarListView {
        return view
    }
}

class StarListViewSpy: StarListView {
    var viewData = StarListViewData.empty
    var delegate: StarListViewDelegate?
}
