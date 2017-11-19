import Foundation

class StarGatewayStub: StarGateway {

    enum Behaviour {
        case loading
        case error
        case success(stars: [Star])
    }

    private let behaviour: Behaviour

    init(_ behaviour: Behaviour) {
        self.behaviour = behaviour
    }

    func loadAll(completion: @escaping (Result<[Star]>) -> Void) {
        switch behaviour {
        case .loading:
            ()
        case .error:
            completion(.error)
        case .success(stars: let stars):
            completion(.success(stars))
        }
    }
}
