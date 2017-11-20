class NASAStarGateway: StarGateway {

    func loadAll(completion: @escaping (Result<[Star]>) -> Void) {
        // TODO: connect to the real NASA API
        completion(.error)
    }
}
