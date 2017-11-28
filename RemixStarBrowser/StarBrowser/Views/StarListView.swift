struct StarListViewData {
    let names: [String]
}

protocol StarListView: class {
    var viewData: StarListViewData { get set }
}
