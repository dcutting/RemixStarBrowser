@objc(WhenThereIsANetworkErrorLoadingTheStar)
class WhenThereIsANetworkErrorLoadingTheStar: NSObject {

    @objc var theErrorScreenIsShown = false

    override init() {

        let wireframe = NavigationWireframeFake()
        let listView = StarListViewSpy()
        let errorView = StarErrorViewSpy()
        let viewFactory = StarBrowserViewDoubleFactory(listView: listView, errorView: errorView)
        let gateway = StarGatewayStub(.error)

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        flow.start()

        listView.selectAnyRow()

        theErrorScreenIsShown = errorView.isOnTop(of: wireframe)
    }
}
