//
//  Constant.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

struct ProjectImp {
}

struct APIsURLConstant {
    static let baseURL = "https://dummyjson.com/"
    static let getTasks = baseURL + "todos"
    static let addTask = baseURL + "todos/add"
}

struct CommonString {
    static let invalidRequest = "Invalid Request"
    static let noDataFound = "No data found"
    static let noInternetConnection = "No Internet Connection"
    static let OK = "OK"
    static let title = "Title"
    static let description = "Description"
    static let save = "Save"
    static let cancel = "Cancel"
    static let done = "Done"
}

struct TasksVWString {
    static let noTaskFound = "No data found"
    static let tasks = "Tasks"
}

struct AddTaskVWString {
    static let addTask = "Add Task"
    static let tasks = "Tasks"
}

struct ImageName {
    static let plus = "plus"
    static let leftArrow = "chevron.left"
    static let rightArrow = "chevron.right"
}
