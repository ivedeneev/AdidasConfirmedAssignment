//
//  AppDelegate.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import UIKit
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupDependensies()
        return true
    }
    
    private func setupDependensies() {
        Resolver.main.register(factory: { ProductServiceImpl() as ProductService })
        Resolver.main.register(factory: { ReviewsServiceImpl() as ReviewsService })
        Resolver.main.register(factory: { RequestBuilderImpl() as RequestBuilder })
        Resolver.main.register(factory: { NetworkClientImpl() as NetworkClient })
        Resolver.main.register(factory: { ProductListPresenterImpl() as ProductListPresenter? })
        Resolver.main.register(factory: { URLSession.shared as URLSession })
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

