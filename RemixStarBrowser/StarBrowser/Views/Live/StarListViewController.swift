import Layout

class StarListViewController: LayoutViewController, StarListView, UITableViewDataSource, UITableViewDelegate {

    var viewData = StarListViewData(entries: []) {
        didSet {
            updateView()
        }
    }

    weak var delegate: StarListViewDelegate?

    private func updateView() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView?

    init() {
        super.init(nibName: nil, bundle: nil)
        loadLayout(named: "StarListView.xml", state: [:])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.entries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node = tableView.dequeueReusableCellNode(withIdentifier: "StarListCell", for: indexPath)
        let name = viewData.entries[indexPath.row].name
        node.setState(["name": name])
        guard let cell = node.view as? UITableViewCell else { preconditionFailure() }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let starID = viewData.entries[indexPath.row].id
        delegate?.didSelect(starID: starID)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
