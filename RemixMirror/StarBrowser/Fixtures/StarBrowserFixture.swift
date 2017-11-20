class StarBrowserFixture: NSObject {

    lazy var nav = NavigationWireframeFake()
    lazy var views = StarBrowserViewDoubleFactory()
    lazy var gateway = StarGatewayStub()
    lazy var flow = StarBrowserFlow(deps: deps)

    private lazy var deps = StarBrowserFlow.Dependencies(navigationWireframe: nav,
                                                         starBrowserViewFactory: views,
                                                         starGateway: gateway)
}
