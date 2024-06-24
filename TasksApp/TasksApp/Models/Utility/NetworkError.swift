//
//  NetworkError.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

class NetworkError: CommonError {
    var httpStatusCode: Int?
    var requestUrl: URL?
    var requestBody: String?
    var serverResponse: String?
    
    init(withServerResponse response: Data? = nil, forRequestUrl url: URL, withHttpBody body: Data? = nil, errorMessage message: String, forStatusCode statusCode: Int) {
        super.init(errorMessage: message)
        self.serverResponse = response != nil ? String(data: response!, encoding: .utf8) : nil
        self.requestUrl = url
        self.requestBody = body != nil ? String(data: body!, encoding: .utf8) : nil
        self.httpStatusCode = statusCode
    }
}
