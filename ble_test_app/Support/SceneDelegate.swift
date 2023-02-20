//
//  SceneDelegate.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 17.02.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let assembly = MainAssembly()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        assembly.createMainPresenter()
        
        let nc = UINavigationController()
        nc.viewControllers = [assembly.view]
        
//        nc.navigationBar.prefersLargeTitles = true
        nc.title = "Device Manager"
        
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
}

