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
        let gateway = StarGatewayStub(.success(stars: stubbedStars))

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: wireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        flow.start()

        let entries = listView.viewData.entries

        guard let row = selectedRow?.intValue, (0..<entries.count).contains(row) else { return }

        let starID = listView.viewData.entries[row].id
        listView.delegate?.didSelectStar(withID: starID)

        detailScreenTitle = detailView.viewData.title
        detailScreenText = detailView.viewData.text
    }
}
