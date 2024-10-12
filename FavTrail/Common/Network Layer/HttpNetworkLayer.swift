//
//  HttpNetworkLayer.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 15/08/22.
//

import Foundation

enum HttpRequestType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

enum NetworkError: String, Error {
    case networkIrresponsiveError = "Error while getting response."
    case urlCodingError = "Url not working."
    case parsingError = "Error while parsing."
    case emptyDataError = "Data is not coming"
}

class HttpNetworkLayer {
    
    static func createRequest(apiEndPoint: ApiEndpoint) -> URLRequest? {

        var components = URLComponents()
        components.scheme = "https"
        components.host = apiEndPoint.baseURL
        components.path = apiEndPoint.domainPath ?? ""
        
        if let queryItems = apiEndPoint.queryItems {
            var queryItemList: [URLQueryItem] = []
            queryItemList = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
            components.queryItems = queryItemList
        }
        
        guard let url = components.url else {
            return nil //TODO: add if needed
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiEndPoint.httpMethod.rawValue
        
        if apiEndPoint.httpMethod == .POST {
            request.httpBody = apiEndPoint.httpBody
        }
        
        return request
    }
    
    private func uploadMultiPartData<Response: Codable>(_ request: inout URLRequest, _ multiPartFormData: [(String, String)], _ completion: @escaping (Result<Response, NetworkError>) -> Void) {
        let lineBreak = "\r\n"
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        let boundaryPrefix = " — \(boundary)\r\n"
        
        for (key, val) in multiPartFormData {
            body.append(boundaryPrefix .data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
            body.append("\(val)\(lineBreak)" .data(using: .utf8)!)
        }
        
        body.append("--\(boundary) --\(lineBreak)" .data(using: .utf8)!)
        request.addValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        
        let dataTask = URLSession.shared.uploadTask(with: request, from: body) { data, httpResponse, error in
            if error == nil {
                guard let data = data else {
                    completion(.failure(.emptyDataError))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.urlCodingError))
                }
            } else {
                completion(.failure(.networkIrresponsiveError))
            }
        }
        dataTask.resume()
    }
    
    private func fetchData<Response: Codable>(_ request: inout URLRequest, _ completion: @escaping (Result<Response, NetworkError>) -> Void) {
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, httpResponse, error in
            if error == nil {
                guard let data = data else {
                    completion(.failure(.emptyDataError))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedData))
                } catch let err {
                    self?.logError(error: err)
                    completion(.failure(.urlCodingError))
                }
            } else {
                completion(.failure(.networkIrresponsiveError))
            }
        }
        dataTask.resume()
    }
    
    func request<Response: Codable>(request: URLRequest, responseType: Response.Type, multiPartFormData: [(String, String)]? = nil, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        
        var request = request
        if let multiPartFormData = multiPartFormData {
            uploadMultiPartData(&request, multiPartFormData, completion)
        } else {
            fetchData(&request, completion)
        }
    }
    
    private func logError(error: Error) {
        if let error = error as? DecodingError {
            switch error {
            case .typeMismatch(_, let context):
                print("ERROR: decoding error desc: \(String(describing: context))")
                var keyPath: String = ""
                _ = context.codingPath.map {
                    keyPath += $0.stringValue + " -> "
                }
                print("ERROR: decoding error path: \(keyPath)")
            case .valueNotFound(_, let context):
                print("ERROR: value not found desc: \(String(describing: context))")
            case .keyNotFound(_, let context):
                print("ERROR: key not found desc: \(String(describing: context))")
            case .dataCorrupted(let context):
                print("ERROR: data corruption desc: \(String(describing: context))")
            @unknown default:
                print("ERROR: unknown")
            }
        }
    }
}
