import Layout

class StarLoadingViewController: LayoutViewController, StarLoadingView {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        loadLayout(named: "StarLoadingView.xml")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
