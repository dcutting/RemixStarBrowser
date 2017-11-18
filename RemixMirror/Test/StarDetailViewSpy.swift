class StarDetailViewDoubleFactory: StarDetailViewFactory {

    var view = StarDetailViewSpy()

    func make() -> StarDetailView {
        return view
    }
}

class StarDetailViewSpy: StarDetailView {
    var viewData = StarDetailViewData.empty
}
