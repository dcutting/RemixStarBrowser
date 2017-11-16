//  Copyright © 2017 Schibsted. All rights reserved.

// App Flow

class AppFlow {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let starListViewFactory: StarListViewFactory
        let starDetailViewFactory: StarDetailViewFactory
        let starsGateway: StarsGateway
    }

    let browser: StarBrowserFlow

    init(deps: Dependencies) {

        let starsAgent = StarsAgent(gateway: deps.starsGateway)
        let pushStarsUseCase = PushStarsUseCase(agent: starsAgent)
        let viewStarUseCase = ViewStarUseCase(agent: starsAgent)
        let starBrowserDeps = StarBrowserFlow.Dependencies(navigationWireframe: deps.navigationWireframe,
                                                           starListViewFactory: deps.starListViewFactory,
                                                           starDetailViewFactory: deps.starDetailViewFactory,
                                                           pushStarsUseCase: pushStarsUseCase,
                                                           viewStarUseCase: viewStarUseCase)
        browser = StarBrowserFlow(deps: starBrowserDeps)
    }

    func start() {
        browser.delegate = self
        browser.start()
    }
}

extension AppFlow: StarBrowserFlowDelegate {
    func didFinish() {
    }
}

// Star Browser Flow

protocol StarBrowserFlowDelegate: class {
    func didFinish()
}

class StarBrowserFlow {

    struct Dependencies {
        let navigationWireframe: NavigationWireframe
        let starListViewFactory: StarListViewFactory
        let starDetailViewFactory: StarDetailViewFactory
        let pushStarsUseCase: PushStarsUseCase
        let viewStarUseCase: ViewStarUseCase
    }
    let deps: Dependencies
    weak var delegate: StarBrowserFlowDelegate?

    private var listView: StarListView?
    private var detailView: StarDetailView?

    init(deps: Dependencies) {
        self.deps = deps
    }

    func start() {
        let view = deps.starListViewFactory.make()
        deps.navigationWireframe.push(view)
        listView = view
        deps.pushStarsUseCase.subscribe()
    }
}

extension StarBrowserFlow: PushStarsUseCaseDelegate {

    func didUpdate(stars: [Star]) {
        listView?.viewData = StarListViewFormatter().prepare(stars: stars)
    }
}

extension StarBrowserFlow: StarListViewDelegate {

    func didSelect(starID: Star.ID) {
        deps.viewStarUseCase.fetchStar(withID: starID)
        let view = deps.starDetailViewFactory.make()
        deps.navigationWireframe.push(view)
        view.viewData = StarDetailViewFormatter().prepare(star: nil)
        detailView = view
    }

    func didTapDone() {
        finish()
    }

    private func finish() {
        deps.pushStarsUseCase.unsubscribe()
        delegate?.didFinish()
    }
}

extension StarBrowserFlow: ViewStarUseCaseDelegate {

    func didFetch(star: Star) {
        detailView?.viewData = StarDetailViewFormatter().prepare(star: star)
    }

    func didFail() {
        detailView?.viewData = StarDetailViewFormatter().prepare(star: star)
    }
}

// Star List View Formatter

class StarListViewFormatter {

    func prepare(stars: [Star]) -> StarListViewData {
        return StarListViewData.empty   // TODO
    }
}

// Star List View

struct StarListViewData {

    struct Entry {
        let id: Star.ID
        let name: String
    }

    let entries: [Entry]

    static var empty: StarListViewData {
        return StarListViewData(entries: [])
    }
}

protocol StarListViewDelegate: class {
    func didSelect(starID: Star.ID)
    func didTapDone()
}

protocol StarListView: Navigatable {
    var viewData: StarListViewData { get set }
    var delegate: StarListViewDelegate? { get set }
}

protocol StarListViewFactory: class {
    func make() -> StarListView
}

// Star Detail View Formatter

class StarDetailViewFormatter {
}

// Star Detail View

enum StarDetailViewData {
    let name: String
    let description: String
}

protocol StarDetailView: Navigatable {
    var viewData: StarDetailViewData { get set }
}

protocol StarDetailViewFactory: class {
    func make() -> StarDetailView
}

// Push Star Use Case
// Subscribes to a refreshing list of stars.

protocol PushStarsUseCaseDelegate: class {
    func didUpdate(stars: [Star])
}

class PushStarsUseCase {

    let agent: StarsAgent
    weak var delegate: PushStarsUseCaseDelegate?
    var subscription: StarsAgent.Subscription?

    init(agent: StarsAgent) {
        self.agent = agent
    }

    func subscribe() {
        subscription = agent.subscribe { update in
        }
    }

    func unsubscribe() {
        agent.unsubscribe(subscription: subscription)
    }
}

// View Star Use Case
// Loads a single star.

protocol ViewStarUseCaseDelegate: class {
    func didFetch(star: Star)
    func didFail()
}

class ViewStarUseCase {

    let agent: StarsAgent
    weak var delegate: ViewStarUseCaseDelegate?

    init(agent: StarsAgent) {
        self.agent = agent
    }

    func fetchStar(withID id: Star.ID) {
        agent.fetchStar(withID: id) { [weak self] result in
            switch result {
            case .success(let star):
                self?.delegate?.didFetch(star: star)
            case .error:
                self?.delegate?.didFail()
            }
        }
    }
}

// Stars Agent
// Subscribable cache of all stars.

class StarsAgent {

    typealias Subscription = Identifier<StarsAgent>
    typealias SubscriptionHandler = (Result<[Star]>) -> Void

    enum StarsAgentError: Error {
        case notFound
        case unavailable
    }

    let gateway: StarsGateway
    private var subscribers = [Subscription: SubscriptionHandler]()
    private var latestStars: [Star]?

    init(gateway: StarsGateway) {
        self.gateway = gateway
    }

    func subscribe(onNext handler: @escaping SubscriptionHandler) -> Subscription {
        let subscription = Subscription.make()
        subscribers[subscription] = handler
        return subscription
        // TODO: fire updates periodically.
    }

    func unsubscribe(subscription: Subscription?) {
        guard let subscription = subscription else { return }
        subscribers.removeValue(forKey: subscription)
    }

    func fetchStars(completion: (Result<[Star]>) -> Void) {
        gateway.loadAll { result in
            if case .success(let stars) = result {
                latestStars = stars
            }
            completion(result)
        }
    }

    func fetchStar(withID id: Star.ID, completion: (Result<Star>) -> Void) {
        fetchStars { result in
            switch result {
            case .success(let stars):
                if let star = stars.first(where: { $0.id == id }) {
                    completion(.success(star))
                } else {
                    completion(.error(StarsAgentError.notFound))
                }
            case .error:
                completion(.error(StarsAgentError.unavailable))
            }
        }
    }
}

// Stars Gateway
// Thin wrapper around network calls to web service.

enum StarsGatewayError: Error {
    case network
    case unknown
}

protocol StarsGateway {
    func loadAll(completion: (Result<[Star]>) -> Void)
}

// Star

struct Star {

    typealias ID = Identifier<Star>

    let id: ID
    let name: String
    let description: String
}
