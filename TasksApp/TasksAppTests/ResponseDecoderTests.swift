//
//  ResponseDecoderTests.swift
//  TasksAppUITests
//
//  Created by AdminFS on 28/07/23.
//

import XCTest
@testable import TasksApp

final class ResponseDecoderTests: XCTestCase {
    
    var responseDecoder: ResponseDecoder!
    
    override func setUpWithError() throws {
        let decoder = JSONDecoder()
        responseDecoder = ResponseDecoder()
        responseDecoder.configure(configuration: ResponseDecoder.ResponseDecoderConfiguration(decoder: decoder))
    }
    
    override func tearDownWithError() throws {
        responseDecoder = nil
    }
    
    func testExample() throws {
        let data = """
        {
            "task_id": 1103,
            "task_detail": {
                "title": "Jkjdlldsdf",
                "description": "Ldsfjldfjslfjljsds",
                "created_date": "2023-07-05"
            }
        }
        """.data(using: .utf8)
        responseDecoder.decodeResponse(data: data!, responseType: Task.self) { result in
            switch result {
            case .success(let movies):
                XCTAssertNoThrow(movies)
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
