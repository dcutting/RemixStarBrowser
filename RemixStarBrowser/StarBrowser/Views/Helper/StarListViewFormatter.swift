class StarListViewFormatter {

    func prepare(stars: [Star]) -> StarListViewData {
        let entries = stars.map { star in
            StarListViewData.Entry(id: star.id, name: star.name)
        }
        return StarListViewData(entries: entries)
    }
}
