@objc(WhenTheStarSuccessfullyLoads)
class WhenTheStarSuccessfullyLoads: NSObject {

    @objc var theVisibleScreenIs: String?

    override init() {

        let wireframe = NavigationWireframeFake()
        let listView = StarListViewSpy()
        let detailView = StarDetailViewSpy()
        let viewFactory = StarBrowserViewDoubleFactory(listView: listView, detailView: detailView)
        let gateway = StarGatewayStub(.success(stubbedStars))

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        flow.start()

        listView.selectAnyRow()

        theVisibleScreenIs = wireframe.topScreenName
    }
}
