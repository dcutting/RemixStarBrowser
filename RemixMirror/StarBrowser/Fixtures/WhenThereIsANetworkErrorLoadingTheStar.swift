@objc(WhenThereIsANetworkErrorLoadingTheStar)
class WhenThereIsANetworkErrorLoadingTheStar: StarBrowserFixture {

    override init() {
        super.init()

        gateway.behaviour = .success(stubbedStars)
        flow.start()
        gateway.behaviour = .error
        views.listView.selectAnyRow()
    }
}
