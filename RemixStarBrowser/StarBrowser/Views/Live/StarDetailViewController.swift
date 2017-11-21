import Layout

class StarDetailViewController: LayoutViewController, StarDetailView {

    var viewData = StarDetailViewData.empty {
        didSet {
            updateViews()
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        loadLayout(named: "StarDetailView.xml", state: viewData)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutDidLoad() {
        updateViews()
    }

    private func updateViews() {
        DispatchQueue.main.async {
            self.layoutNode?.setState(self.viewData, animated: true)
        }
    }
}
