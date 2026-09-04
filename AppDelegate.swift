import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Eğer iOS sahneyi (SceneDelegate) kullanmıyorsa doğrudan pencereyi burada açıyoruz
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = TodoListViewController()
        let navController = UINavigationController(rootViewController: mainVC)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        print("🚀 [AppDelegate] Pencere başarıyla açıldı!")
        return true
    }

    // UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
    }
}
