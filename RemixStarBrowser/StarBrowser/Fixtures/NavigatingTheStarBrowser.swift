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

    @objc func whenTheNetwork(_ condition: String) {
        switch condition {
        case "is slow":
            gateway.behaviour = .loading
        case "is working properly":
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
