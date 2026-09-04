import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let mainVC = TodoListViewController()
        let navController = UINavigationController(rootViewController: mainVC)
        
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
        print("🚀 SCENEDELEGATE PENCEREYİ AÇTI")
    }
}
