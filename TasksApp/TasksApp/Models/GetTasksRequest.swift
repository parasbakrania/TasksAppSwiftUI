//
//  GetTasksRequest.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

// MARK: - GetTasksRequest
struct GetTasksRequest: Encodable {
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
