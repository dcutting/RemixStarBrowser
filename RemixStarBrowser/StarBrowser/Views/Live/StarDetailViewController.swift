import Layout

class StarDetailViewController: LayoutViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        loadLayout(named: "StarDetailView.xml", state: [:])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
