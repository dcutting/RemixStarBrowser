@objc(NavigatingTheStarBrowser)
class NavigatingTheStarBrowser: NSObject {

    let navigator = NavigatorFake()
    let listView = StarListViewSpy()
    let detailView = StarDetailViewSpy()
    let flow: StarBrowserFlow

    override init() {

        let viewFactory = StarBrowserViewSpyFactory()
        viewFactory.listView = listView

        let gateway = StarGatewayStub()
        gateway.stars = stubbedStars

        let deps = StarBrowserFlow.Dependencies(navigator: navigator,
                                                viewFactory: viewFactory,
                                                starGateway: gateway)
        flow = StarBrowserFlow(deps: deps)
        flow.start()
    }

    @objc func selectAStar() {
        guard let starID = listView.viewData.entries.first?.id else { return }
        listView.delegate?.didSelect(starID: starID)
    }

    @objc var theVisibleScreenIs: String {
        get {
            let top = navigator.visible
            if top is StarListView {
                return "list"
            } else if top is StarDetailView {
                return "detail"
            }
            return ""
        }
    }

    @objc func goBack() {
        navigator.pop()
    }
}
