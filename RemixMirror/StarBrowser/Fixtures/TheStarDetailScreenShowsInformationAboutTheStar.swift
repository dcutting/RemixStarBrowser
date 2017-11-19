@objc(TheStarDetailScreenShowsInformationAboutTheStar)
class TheStarDetailScreenShowsInformationAboutTheStar: NSObject {

    @objc var selectedRow: NSNumber?
    @objc var detailScreenTitle: String?
    @objc var detailScreenText: String?

    @objc func reset() {
        selectedRow = nil
        detailScreenTitle = nil
        detailScreenText = nil
    }

    @objc func execute() {

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

        listView.select(row: selectedRow)

        detailScreenTitle = detailView.viewData.title
        detailScreenText = detailView.viewData.text
    }
}
