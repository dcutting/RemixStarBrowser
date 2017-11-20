@objc(TheStarDetailScreenShowsMoreInformationAboutTheSelectedStar)
class TheStarDetailScreenShowsMoreInformationAboutTheSelectedStar: StarBrowserFixture {

    @objc var selectedRow: NSNumber?
    @objc var detailScreenTitle: String?
    @objc var detailScreenText: String?

    @objc func execute() {

        gateway.behaviour = .success(stubbedStars)
        flow.start()

        views.list.select(row: selectedRow)

        detailScreenTitle = views.detail.viewData.title
        detailScreenText = views.detail.viewData.text
    }
}
