import Foundation

class StarGatewayStub: StarGateway {

    var stars: [Star]?

    func loadAll(completion: @escaping (Result<[Star]>) -> Void) {
        DispatchQueue.main.async {
            if let stars = self.stars {
                completion(.success(stars))
            } else {
                completion(.error)
            }
        }
    }
}
