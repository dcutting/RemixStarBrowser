import Layout

class ViewDataLayoutViewController<ViewData: Emptyable>: LayoutViewController {

    var viewData = ViewData.empty {
        didSet {
            updateViewsOnMainQueue()
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
        updateViewsOnMainQueue()
    }

    private func updateViewsOnMainQueue() {
        onMainQueue {
            self.updateViews()
        }
    }

    func updateViews() {
        self.layoutNode?.setState(self.viewData, animated: true)
    }
}
