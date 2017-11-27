struct StarDetailViewData {
    let title: String
    let text: String
}

protocol StarDetailView: Navigatable {
    var viewData: StarDetailViewData { get set }
}
