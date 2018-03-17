import UIKit

class StarBrowserViewControllerFactory: StarBrowserViewFactory {

    func makeListView() -> StarListView {
        return StarListViewController()
    }

    func makeLoadingView() -> StarLoadingView {
        return StarLoadingViewController()
    }

    func makeErrorView() -> StarErrorView {
        return StarErrorViewController()
    }

    func makeDetailView() -> StarDetailView {
        let storyboard = UIStoryboard(name: "StarDetailView", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "StarDetailViewController")
        return view as! StarDetailView
    }
}
