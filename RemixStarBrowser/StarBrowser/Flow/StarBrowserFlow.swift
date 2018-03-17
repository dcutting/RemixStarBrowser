class StarBrowserFlow {

    struct Dependencies {
        let navigator: Navigator
        let starBrowserViewFactory: StarBrowserViewFactory
        let starGateway: StarGateway
    }
    private let deps: Dependencies

    private var listView: StarListView?

    init(deps: Dependencies) {
        self.deps = deps
    }

    func start() {
        pushListView()
        fetchStars()
    }

    private func pushListView() {
        let view = deps.starBrowserViewFactory.makeListView()
        view.delegate = self
        deps.navigator.push(view)
        listView = view
    }

    private func fetchStars() {
        deps.starGateway.loadAll { result in
            if case .success(let stars) = result {
                self.listView?.viewData = StarListViewFormatter().prepare(stars: stars)
            }
        }
    }
}

extension StarBrowserFlow: StarListViewDelegate {

    func didSelectStar(withID id: Star.ID) {
        presentLoadingView {
            self.loadStar(withID: id)
        }
    }

    private func presentLoadingView(completion: Callback?) {
        let view = deps.starBrowserViewFactory.makeLoadingView()
        deps.navigator.present(view, completion: completion)
    }

    private func loadStar(withID id: Star.ID) {
        deps.starGateway.loadAll { result in
            self.dismissLoadingView {
                self.showStar(withID: id, from: result)
            }
        }
    }

    private func dismissLoadingView(completion: Callback?) {
        self.deps.navigator.dismiss(completion: completion)
    }

    private func showStar(withID id: Star.ID, from result: Result<[Star]>) {
        if case .success(let stars) = result, let star = stars.first(where: { $0.id == id }) {
            self.show(star: star)
        } else {
            self.showError()
        }
    }

    private func show(star: Star) {
        let view = deps.starBrowserViewFactory.makeDetailView()
        view.viewData = StarDetailViewFormatter().prepare(star: star)
        deps.navigator.push(view)
    }

    private func showError() {
        let view = deps.starBrowserViewFactory.makeErrorView()
        deps.navigator.push(view)
    }
}
