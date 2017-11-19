@objc(WhenIGoBackFromTheDetailScreen)
class WhenIGoBackFromTheDetailScreen: StarBrowserFixture {
    
    override init() {
        super.init()

        gateway.behaviour = .success(stubbedStars)
        flow.start()
        views.list.selectAnyRow()
        nav.pop()
    }
}
