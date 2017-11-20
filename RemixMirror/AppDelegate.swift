import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootFlow: StarBrowserFlow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationControllerWireframe()
        rootFlow = makeStarBrowserFlow(navigationWireframe: navigationController)
        configureWindow(rootViewController: navigationController)
        rootFlow?.start()

        return true
    }

    private func makeStarBrowserFlow(navigationWireframe: NavigationWireframe) -> StarBrowserFlow {

        let viewFactory = StarBrowserViewControllerFactory()
        let stars = [
            Star(id: Star.ID.make(), name: "Sirius", summary: "Sirius is a star system and the brightest star in the Earth's night sky."),
            Star(id: Star.ID.make(), name: "Canopus", summary: "Canopus is the brightest star in the southern constellation of Carina."),
            Star(id: Star.ID.make(), name: "Arcturus", summary: "Together with Spica and Denebola, Arcturus is part of the Spring Triangle asterism.")
        ]
        let gateway = StarGatewayStub(.success(stars))  // Use NASAStarGateway in real app.

        let deps = StarBrowserFlow.Dependencies(navigationWireframe: navigationWireframe,
                                                starBrowserViewFactory: viewFactory,
                                                starGateway: gateway)
        return StarBrowserFlow(deps: deps)
    }

    private func configureWindow(rootViewController: UIViewController) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
