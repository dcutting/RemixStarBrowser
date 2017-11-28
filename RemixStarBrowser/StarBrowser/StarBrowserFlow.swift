class StarBrowserFlow {

    struct Dependencies {
        let navigator: Navigator
        let viewFactory: StarBrowserViewFactory
        let starGateway: StarGateway
    }

    private let deps: Dependencies
    private var listView: StarListView?

    init(deps: Dependencies) {
        self.deps = deps
    }

    func start() {
        let listView = deps.viewFactory.makeListView()
        listView.delegate = self
        deps.navigator.push(listView)
        self.listView = listView

        deps.starGateway.loadAll { result in
            if case .success(let stars) = result {
                self.show(stars: stars)
            }
        }
    }

    private func show(stars: [Star]) {
        listView?.viewData = prepare(stars: stars)
    }

    private func prepare(stars: [Star]) -> StarListViewData {
        let entries = stars.map {
            StarListViewData.Entry(id: $0.id, name: $0.name)
        }
        return StarListViewData(entries: entries)
    }
}

extension StarBrowserFlow: StarListViewDelegate {

    func didSelect(starID: Star.ID) {
        let detailView = deps.viewFactory.makeDetailView()
        deps.navigator.push(detailView)
    }
}
