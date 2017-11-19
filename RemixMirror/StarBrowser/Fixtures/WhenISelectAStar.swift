@objc(WhenISelectAStar)
class WhenISelectAStar: StarBrowserFixture {
    
    override init() {
        super.init()

        gateway.behaviour = .success(stubbedStars)
        flow.start()
        gateway.behaviour = .loading
        views.listView.selectAnyRow()
    }
}
