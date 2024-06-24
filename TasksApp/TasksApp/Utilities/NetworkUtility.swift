//
//  NetworkUtility.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import Foundation

protocol UtilityProtocol {
    func requestData(from request: Request, completionHandler: @escaping (Result<Data, CommonError>) -> Void)
}

struct NetworkUtility: UtilityProtocol {
    
    var authenticationToken: String?
    
    init(authenticationToken: String? = nil) {
        self.authenticationToken = authenticationToken
    }
    
    func requestData(from request: Request, completionHandler: @escaping (Result<Data, CommonError>) -> Void) {
        guard let request = request as? NetworkRequest else {
            completionHandler(.failure(CommonError(errorMessage: CommonString.invalidRequest)))
            return
        }
        switch request.method {
        case .get:
            getData(requestUrl: request.url) { completionHandler($0) }
        
        case .post:
            postData(request: request) { completionHandler($0) }
            
        default:
            break
        }
    }
    
    // MARK: - Private functions
    private func createUrlRequest(requestUrl: URL) -> URLRequest {
        var urlRequest = URLRequest(url: requestUrl)
        if authenticationToken != nil {
            urlRequest.setValue(authenticationToken!, forHTTPHeaderField: "authorization")
        }
        
        return urlRequest
    }
    
    // MARK: - GET API
    private func getData(requestUrl: URL, completionHandler: @escaping (Result<Data, CommonError>) -> Void) {
        var urlRequest = self.createUrlRequest(requestUrl: requestUrl)
        urlRequest.httpMethod = HttpMethod.get.rawValue
        
        performOperation(requestUrl: urlRequest) { result in
            completionHandler(result)
        }
    }
    
    // MARK: - POST API
    private func postData(request: NetworkRequest, completionHandler: @escaping (Result<Data, CommonError>) -> Void) {
        var urlRequest = self.createUrlRequest(requestUrl: request.url)
        urlRequest.httpMethod = HttpMethod.post.rawValue
        urlRequest.httpBody = request.requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        performOperation(requestUrl: urlRequest) { result in
            completionHandler(result)
        }
    }
    
    // MARK: - Perform data task
    private func performOperation(requestUrl: URLRequest, completionHandler: @escaping (Result<Data, CommonError>) -> Void) {
        if Reachability.isConnectedToNetwork() {
            URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse, error) in
                let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode
                if (error == nil && data != nil && data?.count != 0) {
                    completionHandler(.success(data!))
                    
                } else {
                    let networkError = NetworkError(withServerResponse: data, forRequestUrl: requestUrl.url!, withHttpBody: requestUrl.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)
                    completionHandler(.failure(networkError))
                    
                }
            }.resume()
        } else {
            completionHandler(.failure(CommonError(errorMessage: CommonString.noInternetConnection)))
        }
    }
}
