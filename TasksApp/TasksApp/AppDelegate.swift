//
//  AppDelegate.swift
//  TasksApp
//
//  Created by AdminFS on 28/07/23.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    ///Dependency injection container object
    let container: DIC = {
        let container = DIC()
        container.register(type: UtilityProtocol.self) { _ in
            return NetworkUtility()
        }
        container.register(type: ResponseDecoder.self) { _ in
            return ResponseDecoder()
        }
        container.register(type: (any CollectionProtocol).self) { dic in
            let configuration = ResponseDecoder.ResponseDecoderConfiguration(decoder: JSONDecoder())
            let utility = dic.resolve(type: UtilityProtocol.self) ?? NetworkUtility()
            let responseDecoder = dic.resolve(type: ResponseDecoder.self, configuration: configuration) ?? ResponseDecoder()
            return TasksViewModel(utility: utility, responseHandler: responseDecoder)
        }
        return container
    }()
    
    static var orientationLock = UIInterfaceOrientationMask.portrait //By default you want all your views to rotate freely

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
