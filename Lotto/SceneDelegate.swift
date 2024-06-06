//
//  SceneDelegate.swift
//  Lotto
//
//  Created by NERO on 6/6/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let mainVC = LottoResultsViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        self.window?.rootViewController = navigationController
        
        self.window?.makeKeyAndVisible()
    }
}
