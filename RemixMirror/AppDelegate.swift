import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootFlow: RootFlow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationControllerWireframe()
        let viewFactory = StarBrowserViewControllerFactory()
        let stars = [
            Star(id: Star.ID.make(), name: "Sirius", summary: "Sirius is a star system and the brightest star in the Earth's night sky."),
            Star(id: Star.ID.make(), name: "Canopus", summary: "Canopus is the brightest star in the southern constellation of Carina."),
            Star(id: Star.ID.make(), name: "Arcturus", summary: "Together with Spica and Denebola, Arcturus is part of the Spring Triangle asterism.")
        ]
        let gateway = StarGatewayStub(.success(stars))
        let deps = RootFlow.Dependencies(navigationWireframe: navigationController,
                                         starBrowserViewFactory: viewFactory,
                                         starGateway: gateway)
        let rootFlow = RootFlow(deps: deps)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        self.rootFlow = rootFlow

        rootFlow.start()

        return true
    }
}
