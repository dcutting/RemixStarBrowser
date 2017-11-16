struct Star {

    typealias ID = Identifier<Star>

    let id: ID
    let name: String
    let description: String
}

class StarService {

    private let gateway: StarGateway

    init(gateway: StarGateway) {
        self.gateway = gateway
    }

    func fetchStars(completion: AsyncResult<[Star]>) {
        gateway.loadAll { result in
            completion(result)
        }
    }

    func fetchStar(withID id: Star.ID, completion: AsyncResult<Star>) {
        fetchStars { result in
            if case .success(let stars) = result, let star = stars.first(where: { $0.id == id }) {
                completion(.success(star))
            } else {
                completion(.error)
            }
        }
    }
}

protocol StarGateway {
    func loadAll(completion: AsyncResult<[Star]>)
}
