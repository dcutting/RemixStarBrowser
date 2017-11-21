class StarBrowserFlow {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let starBrowserViewFactory: StarBrowserViewFactory
        let starGateway: StarGateway
    }
    private let deps: Dependencies

    private let fetchStarsUseCase: FetchStarsUseCase
    private let viewStarUseCase: ViewStarUseCase

    private var listView: StarListView?

    init(deps: Dependencies) {
        self.deps = deps
        let starService = StarService(gateway: deps.starGateway)
        fetchStarsUseCase = FetchStarsUseCase(service: starService)
        viewStarUseCase = ViewStarUseCase(service: starService)
    }

    func start() {
        pushListView()
        fetchStars()
    }

    private func pushListView() {
        let view = deps.starBrowserViewFactory.makeListView()
        view.delegate = self
        deps.navigationWireframe.push(view)
        listView = view
    }

    private func fetchStars() {
        fetchStarsUseCase.fetchStars { stars in
            self.listView?.viewData = StarListViewFormatter().prepare(stars: stars)
        }
    }
}

extension StarBrowserFlow: StarListViewDelegate {

    func didSelectStar(withID id: Star.ID) {
        presentLoadingView {
            self.loadStar(withID: id)
        }
    }

    private func presentLoadingView(completion: (() -> Void)?) {
        let view = deps.starBrowserViewFactory.makeLoadingView()
        deps.navigationWireframe.present(view, completion: completion)
    }

    private func loadStar(withID id: Star.ID) {
        viewStarUseCase.fetchStar(withID: id) { result in
            self.dismissLoadingView {
                self.show(result: result)
            }
        }
    }

    private func dismissLoadingView(completion: (() -> Void)?) {
        self.deps.navigationWireframe.dismiss(completion: completion)
    }

    private func show(result: Result<Star>) {
        switch result {
        case .error:
            showError()
        case .success(let star):
            show(star: star)
        }
    }

    private func showError() {
        let view = deps.starBrowserViewFactory.makeErrorView()
        deps.navigationWireframe.push(view)
    }

    private func show(star: Star) {
        let view = deps.starBrowserViewFactory.makeDetailView()
        view.viewData = StarDetailViewFormatter().prepare(star: star)
        deps.navigationWireframe.push(view)
    }
}
