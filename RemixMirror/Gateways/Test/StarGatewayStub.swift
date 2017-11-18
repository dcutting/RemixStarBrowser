class StarGatewayStub: StarGateway {

    var stars: [Star]?

    func loadAll(completion: (Result<[Star]>) -> Void) {
        if let stars = stars {
            completion(.success(stars))
        } else {
            completion(.error)
        }
    }
}
