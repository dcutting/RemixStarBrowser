class StarListViewFormatter {

    func prepare(stars: [Star]) -> StarListViewData {
        let entries = stars.map { star in
            StarListViewData.Entry(id: star.id, name: star.name)
        }
        return StarListViewData(entries: entries)
    }
}

struct StarListViewData {

    struct Entry {
        let id: Star.ID
        let name: String
    }

    let entries: [Entry]

    static var empty: StarListViewData {
        return StarListViewData(entries: [])
    }
}

protocol StarListViewDelegate: class {
    func didSelectStar(withID id: Star.ID)
    func didTapDone()
}

protocol StarListView: Navigatable {
    var viewData: StarListViewData { get set }
    var delegate: StarListViewDelegate? { get set }
}

protocol StarListViewFactory: class {
    func make() -> StarListView
}
