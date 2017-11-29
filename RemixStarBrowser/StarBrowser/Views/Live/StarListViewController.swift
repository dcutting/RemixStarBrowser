import UIKit

class StarListViewController: ViewDataLayoutViewController<StarListViewData>, StarListView, UITableViewDataSource, UITableViewDelegate {

    var delegate: StarListViewDelegate?

    @IBOutlet var tableView: UITableView?

    override func layoutName() -> String {
        return "StarListView.xml"
    }

    override func updateViews() {
        self.tableView?.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.entries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node = tableView.dequeueReusableCellNode(withIdentifier: "StarListCell", for: indexPath)
        let state = viewData.entries[indexPath.row]
        node.setState(state)
        guard let cell = node.view as? UITableViewCell else { preconditionFailure() }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let star = viewData.entries[indexPath.row]
        delegate?.didSelectStar(withID: star.id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
