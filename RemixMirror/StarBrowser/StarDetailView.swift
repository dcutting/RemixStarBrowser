class StarDetailViewFormatter {
    func prepare(star: Star) -> StarDetailViewData {
        return StarDetailViewData(name: star.name, description: star.description)
    }
}

struct StarDetailViewData {
    let name: String
    let description: String

    static var empty: StarDetailViewData {
        return StarDetailViewData(name: "", description: "")
    }
}

protocol StarDetailView: Navigatable {
    var viewData: StarDetailViewData { get set }
}

protocol StarDetailViewFactory: class {
    func make() -> StarDetailView
}
