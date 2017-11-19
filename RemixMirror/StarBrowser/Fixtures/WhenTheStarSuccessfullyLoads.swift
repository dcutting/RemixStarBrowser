@objc(WhenTheStarSuccessfullyLoads)
class WhenTheStarSuccessfullyLoads: NSObject {

    @objc var theDetailScreenIsShown = false

    override init() {

        let wireframe = NavigationWireframeFake()
        let listView = StarListViewSpy()
        let detailView = StarDetailViewSpy()
        let viewFactory = StarBrowserViewDoubleFactory(listView: listView, detailView: detailView)
        let gateway = StarGatewayStub(.success(stars: stubbedStars))

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        flow.start()

        listView.delegate?.didSelectStar(withID: any())

        let topView = wireframe.navigatables.last

        theDetailScreenIsShown = topView === detailView
    }
}
