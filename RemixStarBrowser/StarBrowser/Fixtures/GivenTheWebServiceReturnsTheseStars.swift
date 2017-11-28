var stubbedStars = [Star]()

@objc(GivenTheWebServiceReturnsTheseStars)
class GivenTheWebServiceReturnsTheseStars: NSObject {

    @objc var name = ""
    @objc var summary = ""

    @objc func execute() {
        let star = Star(id: Star.ID.make(), name: name, summary: summary)
        stubbedStars.append(star)
    }
}
