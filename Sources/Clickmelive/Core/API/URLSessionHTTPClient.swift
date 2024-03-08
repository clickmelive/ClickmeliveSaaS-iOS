//
//  URLSessionHTTPClient.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    
    private var maxLengthForBodyContentLog: Int { 5000 }
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    func execute(with urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        
        //log(request: urlRequest)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}

extension URLSessionHTTPClient {
    private func log(request: URLRequest) {

        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }

        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)

        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"

        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? ""
            let maxLength = maxLengthForBodyContentLog
            if bodyString.length > maxLength {
                let truncatedBody = bodyString.substring(to: maxLength)
                logOutput += "\n \(truncatedBody)... [Content truncated for brevity]"
            } else {
                logOutput += "\n \(bodyString)"
            }
        }

        print(logOutput)
    }
}


