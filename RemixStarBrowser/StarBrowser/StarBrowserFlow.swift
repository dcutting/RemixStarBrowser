class StarBrowserFlow {

    struct Dependencies {
        let navigator: Navigator
        let starListView: StarListView
        let starGateway: StarGateway
    }

    private let deps: Dependencies

    init(deps: Dependencies) {
        self.deps = deps
    }

    func start() {
        deps.navigator.push(deps.starListView)
        deps.starGateway.loadAll { result in
            if case .success(let stars) = result {
                self.show(stars: stars)
            }
        }
    }

    private func show(stars: [Star]) {
        deps.starListView.viewData = prepare(stars: stars)
    }

    private func prepare(stars: [Star]) -> StarListViewData {
        let entries = stars.map {
            StarListViewData.Entry(id: $0.id, name: $0.name)
        }
        return StarListViewData(entries: entries)
    }
}
