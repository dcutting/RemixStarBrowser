class StarGatewayStub: StarGateway {

    enum Behaviour {
        case loading
        case error
        case success([Star])
    }

    var behaviour = Behaviour.error

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
