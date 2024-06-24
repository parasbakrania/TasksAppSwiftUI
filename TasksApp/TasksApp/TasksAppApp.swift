//
//  TasksAppApp.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import SwiftUI

@main
struct TasksAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = appDelegate.container.resolve(type: (any CollectionProtocol).self) as? TasksViewModel ?? getTasksViewModel()
            ContentView(observer: viewModel)
        }
    }
    
    func getTasksViewModel() -> TasksViewModel {
        let networkUtility = NetworkUtility()
        let responseDecoder = ResponseDecoder()
        responseDecoder.decoder = JSONDecoder()
        return TasksViewModel(utility: networkUtility, responseHandler: responseDecoder)
    }
    
    
}
