@objc(NavigatingTheStarBrowser)
class NavigatingTheStarBrowser: NSObject {

    let navigator = NavigatorFake()
    let listView = StarListViewSpy()
    let flow: StarBrowserFlow

    override init() {

        let gateway = StarGatewayStub()
        gateway.stars = stubbedStars

        let deps = StarBrowserFlow.Dependencies(navigator: navigator,
                                                starListView: listView,
                                                starGateway: gateway)
        flow = StarBrowserFlow(deps: deps)
        flow.start()
    }

    @objc func selectAStar() {
        guard let starID = stubbedStars.first?.id else { return }
        listView.delegate?.didSelect(starID: starID)
    }

    @objc var theVisibleScreenIs: String {
        get {
            let top = navigator.visible
            if top is StarListView {
                return "list"
            }
            return ""
        }
    }

    @objc func goBack() {
        navigator.pop()
    }
}
