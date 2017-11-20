import Layout

class StarListViewController: LayoutViewController, StarListView {

    var viewData = StarListViewData.empty
    var delegate: StarListViewDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
        loadLayout(named: "StarListView.xml")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarListViewController: UITableViewDataSource, UITableViewDelegate {

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
