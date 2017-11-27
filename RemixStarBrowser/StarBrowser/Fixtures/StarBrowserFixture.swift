class StarBrowserFixture: NSObject {

    lazy var nav = NavigatorFake()
    lazy var views = StarBrowserViewSpyFactory()
    lazy var gateway = StarGatewayStub()
    lazy var flow = StarBrowserFlow(deps: deps)

    private lazy var deps = StarBrowserFlow.Dependencies(navigator: nav,
                                                         starBrowserViewFactory: views,
                                                         starGateway: gateway)
}
