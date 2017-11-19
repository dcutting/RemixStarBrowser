var stars = [Star]()

@objc(GivenTheWebServiceReturnsTheseStars)
class GivenTheWebServiceReturnsTheseStars: NSObject {

    @objc var id = ""
    @objc var name = ""
    @objc var summary = ""

    @objc func reset() {
        id = ""
        name = ""
        summary = ""
    }

    @objc func execute() {
        let star = Star(id: Star.ID(value: id), name: name, description: summary)
        stars.append(star)
    }
}
