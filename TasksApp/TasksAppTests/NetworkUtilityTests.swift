//
//  NetworkUtilityTests.swift
//  TasksAppTests
//
//  Created by AdminFS on 28/07/23.
//

import XCTest
@testable import TasksApp

final class NetworkUtilityTests: XCTestCase {
    
    var networkUtility: NetworkUtility!
    
    override func setUpWithError() throws {
        networkUtility = NetworkUtility()
    }
    
    override func tearDownWithError() throws {
        networkUtility = nil
    }
    
    func testExample() throws {
        let getTasksURL = URL(string: APIsURLConstant.getTasks)!
        let request = GetTasksRequest(userID: 123)
        let requestBody = try JSONEncoder().encode(request)
        let networkRequest = NetworkRequest(withUrl: getTasksURL, forHttpMethod: .post, requestBody: requestBody)
        networkUtility.requestData(from: networkRequest) { result in
            switch result {
            case .success(let data):
                XCTAssertNoThrow(data)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            
            // Put the code you want to measure the time of here.
        }
    }
    
}
