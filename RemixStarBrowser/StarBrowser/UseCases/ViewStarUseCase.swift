class ViewStarUseCase {

    private let service: StarService

    init(service: StarService) {
        self.service = service
    }

    func fetchStar(withID id: Star.ID, completion: @escaping AsyncResult<Star>) {
        service.fetchStar(withID: id) { result in
            completion(result)
        }
    }
}
