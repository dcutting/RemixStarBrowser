@objc(WhenISelectAStar)
class WhenISelectAStar: NSObject {
    
    private lazy var wireframe = NavigationWireframeFake()
    private lazy var listView = StarListViewSpy()
    private lazy var loadingView = StarLoadingViewSpy()
    private lazy var viewFactory = StarBrowserViewDoubleFactory(listView: listView, loadingView: loadingView)
    private lazy var gateway = StarGatewayStub()
    private lazy var deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                         starBrowserViewFactory: viewFactory,
                                                         starGateway: gateway)
    private lazy var flow = StarBrowserFlow(deps: deps)

    @objc var theVisibleScreenIs: String?

    override init() {
        super.init()

        gateway.behaviour = .success(stubbedStars)
        flow.start()

        gateway.behaviour = .loading
        listView.selectAnyRow()

        theVisibleScreenIs = wireframe.topScreenName
    }
}
