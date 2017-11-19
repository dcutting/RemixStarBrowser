@objc(WhenIGoBackFromTheDetailScreen)
class WhenIGoBackFromTheDetailScreen: StarBrowserFixture {
    
    override init() {
        super.init()

        gateway.behaviour = .success(stubbedStars)
        flow.start()
        views.listView.selectAnyRow()
        nav.pop()
    }
}
