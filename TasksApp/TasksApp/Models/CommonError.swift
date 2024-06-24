//
//  CommonError.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

class CommonError: Error {
    var reason: String?
    
    init(errorMessage message: String) {
        self.reason = message
    }
}
