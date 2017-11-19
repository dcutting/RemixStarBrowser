@objc(WhenISelectAStar)
class WhenISelectAStar: NSObject {
    
    @objc var theLoadingScreenIsShown = false

    override init() {

        let wireframe = NavigationWireframeFake()
        let listView = StarListViewSpy()
        let loadingView = StarLoadingViewSpy()
        let viewFactory = StarBrowserViewDoubleFactory(listView: listView, loadingView: loadingView)
        let gateway = StarGatewayStub(.loading)

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        flow.start()

        listView.delegate?.didSelectStar(withID: any())

        let topView = wireframe.navigatables.last

        theLoadingScreenIsShown = topView === loadingView
    }
}

func any() -> Star.ID {
    return Star.ID(value: "1")
}
