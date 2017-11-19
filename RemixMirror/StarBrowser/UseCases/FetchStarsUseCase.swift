import Foundation

class FetchStarsUseCase {

    private let service: StarService

    init(service: StarService) {
        self.service = service
    }

    func fetchStars(completion: @escaping ([Star]) -> Void) {
        service.fetchStars { result in
            if case .success(let stars) = result {
                completion(stars)
            }
        }
    }
}
