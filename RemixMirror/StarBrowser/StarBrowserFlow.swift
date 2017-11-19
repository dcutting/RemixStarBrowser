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

    let starService: StarService
    let observableStarsUseCase: ObservableStarsUseCase
    let viewStarUseCase: ViewStarUseCase

    private var listView: StarListView?

    init(deps: Dependencies) {
        self.deps = deps
        starService = StarService(gateway: deps.starGateway)
        observableStarsUseCase = ObservableStarsUseCase(service: starService)
        viewStarUseCase = ViewStarUseCase(service: starService)
    }

    func start() {
        let view = deps.starBrowserViewFactory.makeListView()
        deps.navigationWireframe.push(view)
        listView = view

        subscribeForStars()
    }

    private func subscribeForStars() {
        observableStarsUseCase.subscribe { stars in
            self.listView?.viewData = StarListViewFormatter().prepare(stars: stars)
        }
    }
}

extension StarBrowserFlow: StarListViewDelegate {

    func didSelectStar(withID id: Star.ID) {
        loadStar(withID: id)
        let view = deps.starBrowserViewFactory.makeLoadingView()
        deps.navigationWireframe.push(view)
    }

    private func loadStar(withID id: Star.ID) {
        viewStarUseCase.fetchStar(withID: id) { result in
            deps.navigationWireframe.pop()
            switch result {
            case .success(let star):
                show(star: star)
            case .error:
                showError()
            }
        }
    }

    private func show(star: Star) {
        let view = deps.starBrowserViewFactory.makeDetailView()
        view.viewData = StarDetailViewFormatter().prepare(star: star)
        deps.navigationWireframe.push(view)
    }

    private func showError() {
        let view = deps.starBrowserViewFactory.makeErrorView()
        deps.navigationWireframe.push(view)
    }

    func didTapDone() {
        finish()
    }

    private func finish() {
        observableStarsUseCase.unsubscribe()
        delegate?.didFinish()
    }
}
