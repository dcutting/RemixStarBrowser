import UIKit

class StarLoadingViewController: UIAlertController, StarLoadingView {

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Loading"
    }

    override var preferredStyle: UIAlertControllerStyle {
        return .alert
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
