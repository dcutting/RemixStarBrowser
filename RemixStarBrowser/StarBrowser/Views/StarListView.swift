struct StarListViewData {
    let names: [String]
}

protocol StarListViewDelegate: class {
    func didSelect(starID: Star.ID)
}

protocol StarListView: Navigatable {
    var viewData: StarListViewData { get set }
    var delegate: StarListViewDelegate? { get set }
}
