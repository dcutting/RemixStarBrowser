class StarErrorViewDoubleFactory: StarErrorViewFactory {

    var view = StarErrorViewSpy()

    func make() -> StarErrorView {
        return view
    }
}

class StarErrorViewSpy: StarErrorView {
    var viewData = StarErrorViewData.empty
}
