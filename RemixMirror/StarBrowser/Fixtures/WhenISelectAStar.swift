@objc(WhenISelectAStar)
class WhenISelectAStar: NSObject {
    
    @objc var theLoadingScreenIsShown = false

    override init() {

        let wireframe = NavigationWireframeFake()
        let listView = StarListViewSpy()
        let loadingView = StarLoadingViewSpy()
        let viewFactory = StarBrowserViewDoubleFactory(listView: listView, loadingView: loadingView)
        let gateway = StarGatewayStub()

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        gateway.behaviour = .success(stubbedStars)
        flow.start()

        gateway.behaviour = .loading
        listView.selectAnyRow()

        theLoadingScreenIsShown = loadingView.isOnTop(of: wireframe)
    }
}
