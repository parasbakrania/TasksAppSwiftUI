//
//  AddTaskResponse.swift
//  TasksApp
//
//  Created by AdminFS on 28/07/23.
//

import Foundation

// MARK: - AddTaskResponse
struct AddTaskResponse: Decodable {
    let id: Int?
    let todo: String?
    let completed: Bool?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
}
