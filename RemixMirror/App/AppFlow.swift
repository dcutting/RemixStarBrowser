class AppFlow {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let starListViewFactory: StarListViewFactory
        let starLoadingViewFactory: StarLoadingViewFactory
        let starErrorViewFactory: StarErrorViewFactory
        let starDetailViewFactory: StarDetailViewFactory
        let starsGateway: StarGateway
    }

    let browser: StarBrowserFlow

    init(deps: Dependencies) {

        let starService = StarService(gateway: deps.starsGateway)
        let observableStarsUseCase = ObservableStarsUseCase(service: starService)
        let viewStarUseCase = ViewStarUseCase(service: starService)
        let starBrowserDeps = StarBrowserFlow.Dependencies(navigationWireframe: deps.navigationWireframe,
                                                           starListViewFactory: deps.starListViewFactory,
                                                           starLoadingViewFactory: deps.starLoadingViewFactory,
                                                           starErrorViewFactory: deps.starErrorViewFactory,
                                                           starDetailViewFactory: deps.starDetailViewFactory,
                                                           observableStarsUseCase: observableStarsUseCase,
                                                           viewStarUseCase: viewStarUseCase)
        browser = StarBrowserFlow(deps: starBrowserDeps)
    }

    func start() {
        browser.delegate = self
        browser.start()
    }
}

extension AppFlow: StarBrowserFlowDelegate {
    func didFinish() {
    }
}
