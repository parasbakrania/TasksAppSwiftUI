//
//  NetworkRequest.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

protocol Request {
    var url: URL { get set }
    var method: HttpMethod { get set }
}

struct NetworkRequest : Request {
    var url: URL
    var method: HttpMethod
    var requestBody: Data? = nil

    public init(withUrl url: URL, forHttpMethod method: HttpMethod, requestBody: Data? = nil) {
        self.url = url
        self.method = method
        self.requestBody = requestBody != nil ? requestBody : nil
    }
}
