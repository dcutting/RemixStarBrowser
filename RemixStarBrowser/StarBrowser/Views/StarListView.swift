struct StarListViewData {

    struct Entry {
        let id: Star.ID
        let name: String
    }

    let entries: [Entry]
}

protocol StarListViewDelegate: class {
    func didSelect(starID: Star.ID)
}

protocol StarListView: Navigatable {
    var viewData: StarListViewData { get set }
    var delegate: StarListViewDelegate? { get set }
}
