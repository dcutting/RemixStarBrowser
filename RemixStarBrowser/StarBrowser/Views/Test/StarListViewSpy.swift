class StarListViewSpy: StarListView {
    var viewData = StarListViewData(entries: [])
    weak var delegate: StarListViewDelegate?
}
