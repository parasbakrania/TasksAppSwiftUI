//
//  AddTaskRequest.swift
//  TasksApp
//
//  Created by AdminFS on 27/07/23.
//

import Foundation

// MARK: - AddTaskRequest
struct AddTaskRequest: Encodable {
    let todo: String?
    let completed: Bool?
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case todo, completed
        case userID = "userId"
    }
}
