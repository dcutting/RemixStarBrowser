@objc(NavigatingTheStarBrowser)
class NavigatingTheStarBrowser: NSObject {

    let navigator = NavigatorFake()
    let views = StarBrowserViewSpyFactory()

    let flow: StarBrowserFlow

    override init() {

        let gateway = StarGatewayStub()
        gateway.stars = stubbedStars

        let deps = StarBrowserFlow.Dependencies(
            navigator: navigator,
            viewFactory: views
            starGateway: gateway
        )
        flow = StarBrowserFlow(deps: deps)
        flow.start()
    }

    @objc func selectAStar() {

    }

    @objc func theVisibleScreenIs() -> String {
        return "nothing"
    }

    @objc func goBack() {

    }
}
