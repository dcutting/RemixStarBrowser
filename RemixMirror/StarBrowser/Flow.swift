protocol StarBrowserFlowDelegate: class {
    func didFinish()
}

class StarBrowserFlow {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let starListViewFactory: StarListViewFactory
        let starLoadingViewFactory: StarLoadingViewFactory
        let starErrorViewFactory: StarErrorViewFactory
        let starDetailViewFactory: StarDetailViewFactory
        let observableStarsUseCase: ObservableStarsUseCase
        let viewStarUseCase: ViewStarUseCase
    }
    private let deps: Dependencies
    weak var delegate: StarBrowserFlowDelegate?

    private var listView: StarListView?

    init(deps: Dependencies) {
        self.deps = deps
    }

    func start() {
        let view = deps.starListViewFactory.make()
        deps.navigationWireframe.push(view)
        listView = view

        subscribeForStars()
    }

    private func subscribeForStars() {
        deps.observableStarsUseCase.subscribe { stars in
            self.listView?.viewData = StarListViewFormatter().prepare(stars: stars)
        }
    }
}

extension StarBrowserFlow: StarListViewDelegate {

    func didSelectStar(withID id: Star.ID) {
        loadStar(withID: id)
        let view = deps.starLoadingViewFactory.make()
        deps.navigationWireframe.push(view)
    }

    private func loadStar(withID id: Star.ID) {
        deps.viewStarUseCase.fetchStar(withID: id) { result in
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
        let view = deps.starDetailViewFactory.make()
        view.viewData = StarDetailViewFormatter().prepare(star: star)
        deps.navigationWireframe.push(view)
    }

    private func showError() {
        let view = deps.starErrorViewFactory.make()
        deps.navigationWireframe.push(view)
    }

    func didTapDone() {
        finish()
    }

    private func finish() {
        deps.observableStarsUseCase.unsubscribe()
        delegate?.didFinish()
    }
}
