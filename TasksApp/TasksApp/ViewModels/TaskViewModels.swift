//
//  TaskViewModels.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

enum DataState<T: Equatable> {
    case idle
    case loading
    case failed(Error)
    case loaded(T?)
    case added(Decodable?)
}

extension DataState: Equatable {
    static func == (lhs: DataState<T>, rhs: DataState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loaded(let lhsType), .loaded(let rhsType)):
            return lhsType == rhsType
            
        default:
            return false
        }
    }
}

protocol CollectionProtocol: ObservableObject {
    associatedtype Item: Equatable
    
    var state: DataState<[Item]?> { get set }
    func getItems()
    func add(item: Item)
}

class TasksViewModel: CollectionProtocol {
    @Published var state = DataState<[Task]?>.idle
    
    private let utility: UtilityProtocol
    private let responseHandler: ResponseHandlerProtocol
    
    init(utility: UtilityProtocol, responseHandler: ResponseHandlerProtocol) {
        self.utility = utility
        self.responseHandler = responseHandler
    }
    
    func getItems() {
        if let getTasksURL = URL(string: APIsURLConstant.getTasks) {
            let networkRequest = NetworkRequest(withUrl: getTasksURL, forHttpMethod: .get)
            
            self.state = DataState.loading
            self.utility.requestData(from: networkRequest) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.responseHandler.decodeResponse(data: data, responseType: GetTasksResponse.self) { result in
                        switch result {
                        case .success(let response):
                            DispatchQueue.main.async {
                                self?.state = DataState.loaded(response?.todos)
                            }
                            
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self?.state = DataState.failed(error)
                            }
                        }
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.state = DataState.failed(error)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.state = DataState.failed(CommonError(errorMessage: CommonString.invalidRequest))
            }
        }
    }
    
    func add(item: Task) {
        if let userID = item.userID,
           let addTaskURL = URL(string: APIsURLConstant.addTask) {
            
            let validation = AddTaskValidation()
            let result = validation.validate(task: item)
            switch result {
            case .success:
                do {
                    let request = AddTaskRequest(todo: item.todo, completed: item.completed, userID: userID)
                    let requestBody = try JSONEncoder().encode(request)
                    let networkRequest = NetworkRequest(withUrl: addTaskURL, forHttpMethod: .post, requestBody: requestBody)
                    
                    self.state = DataState.loading
                    self.utility.requestData(from: networkRequest) { [weak self] result in
                        switch result {
                        case .success(let data):
                            self?.responseHandler.decodeResponse(data: data, responseType: AddTaskResponse.self) { result in
                                switch result {
                                case .success:
                                    DispatchQueue.main.async {
                                        self?.state = DataState.added(true)
                                    }
                                    
                                case .failure(let error):
                                    DispatchQueue.main.async {
                                        self?.state = DataState.failed(error)
                                    }
                                }
                            }
                            
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self?.state = DataState.failed(error)
                            }
                        }
                    }
                    
                } catch let error {
                    DispatchQueue.main.async {
                        self.state = DataState.failed(error)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = DataState.failed(error)
                }
            }
            
        } else {
            DispatchQueue.main.async {
                self.state = DataState.failed(CommonError(errorMessage: CommonString.invalidRequest))
            }
        }
    }
}
