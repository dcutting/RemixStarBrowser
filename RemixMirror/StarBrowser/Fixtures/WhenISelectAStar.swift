@objc(WhenISelectAStar)
class WhenISelectAStar: NSObject {
    
    @objc var theLoadingScreenIsShown = false

    override init() {

        let navigationWireframe = NavigationWireframeDouble()
        let starBrowserViewFactory = StarBrowserViewDoubleFactory()
        let starGateway = StarGatewayStub()
        starGateway.stars = stars

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: navigationWireframe,
                                                starBrowserViewFactory: starBrowserViewFactory,
                                                starGateway: starGateway)
        let starBrowser = StarBrowserFlow(deps: deps)

        starBrowser.start()

        let listView = starBrowserViewFactory.listView
        listView.delegate?.didSelectStar(withID: any())

        let topView = navigationWireframe.navigatables.last

        let loadingView = starBrowserViewFactory.loadingView

        theLoadingScreenIsShown = topView === loadingView
    }
}

func any() -> Star.ID {
    return Star.ID(value: "1")
}
