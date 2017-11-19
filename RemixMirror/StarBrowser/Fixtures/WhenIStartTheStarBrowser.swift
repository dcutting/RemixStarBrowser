@objc(WhenIStartTheStarBrowser)
class WhenIStartTheStarBrowser: StarBrowserFixture {

    override init() {
        super.init()

        gateway.behaviour = .loading
        flow.start()
    }
}
