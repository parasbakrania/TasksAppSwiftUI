//
//  GetTasksResponse.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

// MARK: - GetTasksResponse
struct GetTasksResponse: Decodable {
    let todos: [Task]
    let total, skip, limit: Int?
    
    enum CodingKeys: String, CodingKey {
        case todos
        case total, skip, limit
    }
}

// MARK: - Task
struct Task: Decodable, Identifiable, Equatable {
    let id: Int?
    let todo: String?
    let completed: Bool?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}

