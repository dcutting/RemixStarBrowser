import Layout

class ViewDataLayoutViewController<ViewData: Emptyable>: LayoutViewController {

    var viewData = ViewData.empty {
        didSet {
            updateViews()
        }
    }

    func layoutName() -> String {
        return ""
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        loadLayout(named: layoutName(), state: viewData)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutDidLoad() {
        updateViews()
    }

    func updateViews() {
        DispatchQueue.main.async {
            self.layoutNode?.setState(self.viewData, animated: true)
        }
    }
}
