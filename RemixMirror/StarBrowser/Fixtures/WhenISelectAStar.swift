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

        listView.selectAnyRow()

        theLoadingScreenIsShown = loadingView.isOnTop(of: wireframe)
    }
}
