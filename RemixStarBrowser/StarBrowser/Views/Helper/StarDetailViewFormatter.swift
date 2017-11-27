class StarDetailViewFormatter {

    func prepare(star: Star) -> StarDetailViewData {
        return StarDetailViewData(title: star.name.uppercased(), text: star.summary)
    }
}
