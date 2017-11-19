@objc(WhenIStartTheStarBrowser)
class WhenIStartTheStarBrowser: NSObject {
    
    @objc var theListScreenIsShown = false

    override init() {

        let wireframe = NavigationWireframeFake()
        let listView = StarListViewSpy()
        let viewFactory = StarBrowserViewDoubleFactory(listView: listView)
        let gateway = StarGatewayStub(.loading)

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        flow.start()

        theListScreenIsShown = listView.isOnTop(of: wireframe)
    }
}
