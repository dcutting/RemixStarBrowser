class StarBrowserFixture: NSObject {

    lazy var navigator = NavigatorFake()
    lazy var views = StarBrowserViewSpyFactory()
    lazy var gateway = StarGatewayStub()
    lazy var flow = StarBrowserFlow(deps: deps)

    private lazy var deps = StarBrowserFlow.Dependencies(navigator: navigator,
                                                         starBrowserViewFactory: views,
                                                         starGateway: gateway)
}
