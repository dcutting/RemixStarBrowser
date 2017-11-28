@objc(ThenTheBrowserShowsTheseStars)
class ThenTheBrowserShowsTheseStars: NSObject {

    @objc func query() -> [[[String]]] {

        let navigator = NavigatorFake()
        let listView = StarListViewSpy()
        let gateway = StarGatewayStub()
        gateway.stars = stubbedStars

        let deps = StarBrowserFlow.Dependencies(
            navigator: navigator,
            starListView: listView,
            starGateway: gateway
        )
        let flow = StarBrowserFlow(deps: deps)
        flow.start()

        let listedStars = listView.viewData.names
        let names = listedStars.map {
            [["name", $0]]
        }

        return names
    }
}
