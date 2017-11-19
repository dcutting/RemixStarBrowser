@objc(ThenTheBrowserListsTheseStars)
class ThenTheBrowserListsTheseStars: NSObject {

    @objc func query() -> [[[String]]] {

        let wireframe = NavigationWireframeFake()
        let listView = StarListViewSpy()
        let viewFactory = StarBrowserViewDoubleFactory(listView: listView)
        let gateway = StarGatewayStub(.success(stars: stubbedStars))

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        flow.start()

        return convertForFitNesse(entries: listView.viewData.entries)
    }

    private func wait(seconds: TimeInterval) {
        RunLoop.current.run(until: Date() + seconds)
    }

    private func convertForFitNesse(entries: [StarListViewData.Entry]) -> [[[String]]] {
        let names = entries.map { entry in
            [["name", entry.name]]
        }
        return names
    }
}
