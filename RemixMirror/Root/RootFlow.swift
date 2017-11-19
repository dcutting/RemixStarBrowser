class RootFlow {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let starBrowserViewFactory: StarBrowserViewFactory
        let starGateway: StarGateway
    }

    let browser: StarBrowserFlow

    init(deps: Dependencies) {

        let starBrowserDeps = StarBrowserFlow.Dependencies(navigationWireframe: deps.navigationWireframe,
                                                           starBrowserViewFactory: deps.starBrowserViewFactory,
                                                           starGateway: deps.starGateway)
        browser = StarBrowserFlow(deps: starBrowserDeps)
    }

    func start() {
        browser.delegate = self
        browser.start()
    }
}

extension RootFlow: StarBrowserFlowDelegate {
    func didFinish() {
    }
}
