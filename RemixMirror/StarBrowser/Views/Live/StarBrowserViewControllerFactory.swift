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
        return StarDetailViewController()
    }
}
