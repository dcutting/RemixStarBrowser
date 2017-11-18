class StarLoadingViewDoubleFactory: StarLoadingViewFactory {

    var view = StarLoadingViewSpy()

    func make() -> StarLoadingView {
        return view
    }
}

class StarLoadingViewSpy: StarLoadingView {
}
