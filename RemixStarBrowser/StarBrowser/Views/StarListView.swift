struct StarListViewData {

    struct Entry {
        let id: Star.ID
        let name: String
    }

    let entries: [Entry]
}

protocol StarListViewDelegate: class {
    func didSelectStar(withID id: Star.ID)
}

protocol StarListView: Navigatable {
    var viewData: StarListViewData { get set }
    var delegate: StarListViewDelegate? { get set }
}
