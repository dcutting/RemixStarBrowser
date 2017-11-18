class NasaStarGateway: StarGateway {

    func loadAll(completion: (Result<[Star]>) -> Void) {
        // TODO: connect to the real Nasa API
        completion(.error)
    }
}
