import Layout

class StarListViewController: LayoutViewController, StarListView {
    var viewData = StarListViewData.empty
    var delegate: StarListViewDelegate?
}
