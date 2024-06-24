//
//  AddTaskValidation.swift
//  TasksApp
//
//  Created by AdminFS on 28/07/23.
//

import Foundation

struct AddTaskValidation {
    
    func validate(task: Task) -> Result<Bool, CommonError> {
        guard let title = task.todo?.trimmingCharacters(in: .whitespacesAndNewlines), title.count > 3 else {
            return .failure(CommonError(errorMessage: "Enter valid title"))
        }
        return .success(true)
    }
}
