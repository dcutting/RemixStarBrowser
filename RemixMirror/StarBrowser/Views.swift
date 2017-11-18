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



protocol StarLoadingView: Navigatable {
}

protocol StarLoadingViewFactory: class {
    func make() -> StarLoadingView
}



struct StarErrorViewData {
    let message: String

    static var empty: StarErrorViewData {
        return StarErrorViewData(message: "")
    }
}

protocol StarErrorView: Navigatable {
    var viewData: StarErrorViewData { get set }
}

protocol StarErrorViewFactory: class {
    func make() -> StarErrorView
}



class StarDetailViewFormatter {
    func prepare(star: Star) -> StarDetailViewData {
        return StarDetailViewData(name: star.name, description: star.description)
    }
}

struct StarDetailViewData {
    let name: String
    let description: String
}

protocol StarDetailView: Navigatable {
    var viewData: StarDetailViewData { get set }
}

protocol StarDetailViewFactory: class {
    func make() -> StarDetailView
}
