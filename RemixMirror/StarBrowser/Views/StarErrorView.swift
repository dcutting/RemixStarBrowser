struct StarErrorViewData {
    let message: String

    static var empty: StarErrorViewData {
        return StarErrorViewData(message: "")
    }
}

protocol StarErrorView: Navigatable {
    var viewData: StarErrorViewData { get set }
}

protocol StarErrorViewFactory: class {
    func make() -> StarErrorView
}
