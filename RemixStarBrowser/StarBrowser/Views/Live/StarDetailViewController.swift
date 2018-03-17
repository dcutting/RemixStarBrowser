import UIKit

class StarDetailViewController: UIViewController, StarDetailView {

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var textView: UITextView?

    var viewData = StarDetailViewData.empty {
        didSet {
            onMainQueue {
                self.updateViews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    private func updateViews() {
        titleLabel?.text = viewData.title
        textView?.text = viewData.text
    }
}
