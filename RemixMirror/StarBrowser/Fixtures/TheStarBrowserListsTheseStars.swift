@objc(TheStarBrowserListsTheseStars)
class TheStarBrowserListsTheseStars: NSObject {

    @objc func query() -> [[[String]]] {

        let navigationWireframe = NavigationWireframeDouble()
        let starBrowserViewFactory = StarBrowserViewDoubleFactory()
        let starGateway = StarGatewayStub()
        starGateway.stars = stars

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: navigationWireframe,
                                                starBrowserViewFactory: starBrowserViewFactory,
                                                starGateway: starGateway)
        let starBrowser = StarBrowserFlow(deps: deps)

        starBrowser.start()

        let listView = starBrowserViewFactory.listView
        let viewData = listView.viewData
        let names = viewData.entries.map { entry in
            [["name", entry.name]]
        }
        return names
    }
}
