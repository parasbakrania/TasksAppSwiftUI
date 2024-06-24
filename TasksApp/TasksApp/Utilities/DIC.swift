//
//  DIC.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

typealias FactoryClosure = (DIC) -> Any

protocol Configurable {
    associatedtype Configuration
    func configure(configuration: Configuration)
}

protocol DICProtocol {
    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure)
    func resolve<Service>(type: Service.Type) -> Service?
    func resolve<Service: Configurable>(type: Service.Type, configuration: Service.Configuration) -> Service?
}

/// Dependency Injection Container Class
class DIC: DICProtocol {
    
    var services = Dictionary<String, FactoryClosure>()
    
    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure) {
        services["\(type)"] = factoryClosure
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"]?(self) as? Service
    }
    
    func resolve<Service>(type: Service.Type, configuration: Service.Configuration) -> Service? where Service : Configurable {
        let service = resolve(type: type)
        service?.configure(configuration: configuration)
        return service
    }
}
