@objc(WhenIGoBackFromTheDetailScreen)
class WhenIGoBackFromTheDetailScreen: NSObject {
    
    @objc var theVisibleScreenIs: String?

    override init() {

        let wireframe = NavigationWireframeFake()
        let listView = StarListViewSpy()
        let viewFactory = StarBrowserViewDoubleFactory(listView: listView)
        let gateway = StarGatewayStub(.success(stubbedStars))

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        flow.start()

        listView.selectAnyRow()

        wireframe.pop()

        theVisibleScreenIs = wireframe.topScreenName
    }
}
