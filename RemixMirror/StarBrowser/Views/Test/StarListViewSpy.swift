class StarListViewSpy: StarListView {
    var viewData = StarListViewData.empty
    var delegate: StarListViewDelegate?

    func selectAnyRow() {
        guard let star = viewData.entries.first else { return }
        delegate?.didSelectStar(withID: star.id)
    }
}
