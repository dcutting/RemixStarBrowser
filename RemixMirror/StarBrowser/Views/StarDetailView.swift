class StarDetailViewFormatter {
    func prepare(star: Star) -> StarDetailViewData {
        return StarDetailViewData(title: star.name.uppercased(), text: star.summary)
    }
}

struct StarDetailViewData {
    let title: String
    let text: String

    static var empty: StarDetailViewData {
        return StarDetailViewData(title: "", text: "")
    }
}

protocol StarDetailView: Navigatable {
    var viewData: StarDetailViewData { get set }
}

protocol StarDetailViewFactory: class {
    func make() -> StarDetailView
}
