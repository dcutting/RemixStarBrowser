import Foundation

class StarDetailViewController: ViewDataLayoutViewController<StarDetailViewData>, StarDetailView {

    override func layoutName() -> String {
        return "StarDetailView.xml"
    }
}
