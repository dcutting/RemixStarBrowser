@objc(ThenTheStarBrowserListsTheseStars)
class ThenTheStarBrowserListsTheseStars: StarBrowserFixture {

    @objc func query() -> [[[String]]] {

        gateway.behaviour = .success(stubbedStars)
        flow.start()
        return convertForFitNesse(entries: views.list.viewData.entries)
    }

    private func convertForFitNesse(entries: [StarListViewData.Entry]) -> [[[String]]] {
        let names = entries.map { entry in
            [["name", entry.name]]
        }
        return names
    }
}
