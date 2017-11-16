import Foundation

class ObservableStarsUseCase {

    typealias Observer = ([Star]) -> Void

    private let service: StarService
    private var observer: Observer?
    private var timer: Timer?

    init(service: StarService) {
        self.service = service
    }

    func subscribe(onNext observer: @escaping Observer) {
        self.observer = observer
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            // Note this is a very poor way to implement an observable.
            self?.service.fetchStars { result in
                if case .success(let stars) = result {
                    observer(stars)
                }
            }
        }
    }

    func unsubscribe() {
        timer?.invalidate()
        timer = nil
        observer = nil
    }
}

class ViewStarUseCase {

    private let service: StarService

    init(service: StarService) {
        self.service = service
    }

    func fetchStar(withID id: Star.ID, completion: AsyncResult<Star>) {
        service.fetchStar(withID: id) { result in
            completion(result)
        }
    }
}
