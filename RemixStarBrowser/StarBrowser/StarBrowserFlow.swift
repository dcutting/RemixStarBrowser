class StarBrowserFlow {

    struct Dependencies {
        let starListView: StarListView
        let starGateway: StarGateway
    }

    private let deps: Dependencies

    init(deps: Dependencies) {
        self.deps = deps
    }

    func start() {
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
        let names = stars.map {
            $0.name
        }
        return StarListViewData(names: names)
    }
}
