class StarDetailViewSpy: StarDetailView {
    var viewData = StarDetailViewData.empty
}

extension StarDetailViewSpy: ScreenNameable {
    var screenName: String {
        return "detail"
    }
}
