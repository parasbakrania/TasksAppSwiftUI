//
//  ParseError.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

class ParseError: CommonError {
    var responseData: String?

    init(withResponse response: Data? = nil, errorMessage message: String) {
        super.init(errorMessage: message)
        self.responseData = response != nil ? String(data: response!, encoding: .utf8) : nil
    }
}
