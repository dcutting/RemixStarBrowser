import Foundation

class StarListViewSpy: StarListView {
    
    var viewData = StarListViewData.empty
    var delegate: StarListViewDelegate?

    func select(row: NSNumber?) {
        guard let row = row?.intValue else { return }
        select(row: row)
    }

    func select(row: Int) {
        guard (0..<viewData.entries.count).contains(row) else { return }
        let star = viewData.entries[row]
        delegate?.didSelectStar(withID: star.id)
    }

    func selectAnyRow() {
        select(row: 0)
    }
}

extension StarListViewSpy: ScreenNameable {
    var screenName: String {
        return "list"
    }
}
