class StarBrowserViewControllerFactory: StarBrowserViewFactory {

    func makeListView() -> StarListView {
        return StarListViewController()
    }

    func makeDetailView() -> StarDetailView {
        return StarDetailViewController()
    }
}
