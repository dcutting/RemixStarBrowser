@objc(TheStarDetailScreenShowsInformationAboutTheStar)
class TheStarDetailScreenShowsInformationAboutTheStar: StarBrowserFixture {

    @objc var selectedRow: NSNumber?
    @objc var detailScreenTitle: String?
    @objc var detailScreenText: String?

    @objc func reset() {
        selectedRow = nil
        detailScreenTitle = nil
        detailScreenText = nil
    }

    @objc func execute() {

        gateway.behaviour = .success(stubbedStars)
        flow.start()

        views.list.select(row: selectedRow)

        detailScreenTitle = views.detail.viewData.title
        detailScreenText = views.detail.viewData.text
    }
}
