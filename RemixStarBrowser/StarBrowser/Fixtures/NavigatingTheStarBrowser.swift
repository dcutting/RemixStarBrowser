@objc(NavigatingTheStarBrowser)
class NavigatingTheStarBrowser: StarBrowserFixture {

    override init() {
        super.init()

        gateway.behaviour = .success(stubbedStars)
        flow.start()
    }

    @objc var theVisibleScreenIs: String? {
        return nav.visibleScreenName
    }

    @objc func whenTheNetworkIs(_ condition: String) {
        switch condition {
        case "slow":
            gateway.behaviour = .loading
        case "working properly":
            gateway.behaviour = .success(stubbedStars)
        default:
            gateway.behaviour = .error
        }
    }

    @objc func selectAStar() {
        views.list.selectAnyRow()
    }

    @objc func goBack() {
        nav.pop()
    }
}
