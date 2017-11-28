class StarGatewayStub: StarGateway {

    var stars = [Star]()

    func loadAll(completion: (Result<[Star]>) -> Void) {
        completion(.success(stars))
    }
}
