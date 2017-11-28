import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootFlow: StarBrowserFlow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let navigator = UIKitNavigator()
        let viewFactory = StarBrowserViewControllerFactory()
        let gateway = StarGatewayStub()
        gateway.stars = makeStars()

        let deps = StarBrowserFlow.Dependencies(navigator: navigator,
                                                viewFactory: viewFactory,
                                                starGateway: gateway)
        let flow = StarBrowserFlow(deps: deps)

        configureWindow(rootViewController: navigator)

        rootFlow = flow
        flow.start()

        return true
    }

    private func makeStars() -> [Star] {
        return [
            Star(id: Star.ID.make(), name: "Sirius", summary: "Bright!"),
            Star(id: Star.ID.make(), name: "Canopus", summary: "Pretty bright.")
        ]
    }

    private func configureWindow(rootViewController: UIViewController) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
