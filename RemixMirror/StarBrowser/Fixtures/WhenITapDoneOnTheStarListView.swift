@objc(WhenITapDoneOnTheStarListView)
class WhenITapDoneOnTheStarListView: StarBrowserFixture {

    @objc var theStarBrowserFinishes = false

    override init() {
        super.init()

        let flowDelegateSpy = StarBrowserFlowDelegateSpy()
        flow.delegate = flowDelegateSpy
        flow.start()
        views.list.delegate?.didTapDone()
        theStarBrowserFinishes = flowDelegateSpy.calledDidFinish
    }
}

private class StarBrowserFlowDelegateSpy: StarBrowserFlowDelegate {

    var calledDidFinish = false

    func didFinish() {
        calledDidFinish = true
    }
}
