import Layout

class StarListViewController: LayoutViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView?

    init() {
        super.init(nibName: nil, bundle: nil)
        loadLayout(named: "StarListView.xml", state: [:])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node = tableView.dequeueReusableCellNode(withIdentifier: "StarListCell", for: indexPath)
        node.setState([:])
        guard let cell = node.view as? UITableViewCell else { preconditionFailure() }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
