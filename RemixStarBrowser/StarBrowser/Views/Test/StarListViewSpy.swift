class StarListViewSpy: StarListView {
    var viewData = StarListViewData(names: [])
    weak var delegate: StarListViewDelegate?
}
