protocol ScreenNameable {
    var screenName: String { get }
}

extension StarListViewSpy: ScreenNameable {
    var screenName: String {
        return "list"
    }
}

extension StarLoadingViewSpy: ScreenNameable {
    var screenName: String {
        return "loading"
    }
}

extension StarErrorViewSpy: ScreenNameable {
    var screenName: String {
        return "error"
    }
}

extension StarDetailViewSpy: ScreenNameable {
    var screenName: String {
        return "detail"
    }
}
