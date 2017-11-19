protocol StarBrowserFlowDelegate: class {
    func didFinish()
}

class StarBrowserFlow {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let starBrowserViewFactory: StarBrowserViewFactory
        let starGateway: StarGateway
    }
    private let deps: Dependencies
    weak var delegate: StarBrowserFlowDelegate?

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
        loadStar(withID: id)
    }

    private func loadStar(withID id: Star.ID) {
        showLoading()
        viewStarUseCase.fetchStar(withID: id) { result in
            self.deps.navigationWireframe.pop()
            switch result {
            case .error:
                self.showError()
            case .success(let star):
                self.show(star: star)
            }
        }
    }

    private func showLoading() {
        let view = deps.starBrowserViewFactory.makeLoadingView()
        deps.navigationWireframe.push(view)
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

    func didTapDone() {
//        delegate?.didFinish()
    }
}
