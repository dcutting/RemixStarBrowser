@objc(WhenTheStarSuccessfullyLoads)
class WhenTheStarSuccessfullyLoads: StarBrowserFixture {

    override init() {
        super.init()

        gateway.behaviour = .success(stubbedStars)
        flow.start()
        views.listView.selectAnyRow()
    }
}
