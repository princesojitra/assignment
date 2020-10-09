//
//  APIManager.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit


typealias Parameters = [String:String]
typealias ResponseBody = Any
typealias ReesultComplitionBlock = (Result<Decodable?,APIError>) -> Void
typealias HTTPHeaders = [String: String]

//Error types
enum APIError: Error {
    case requestFailed
    case failedToCreateURL
    case invalidData
    case jsonParsingFailure
    case internetConecctionNotAvailable
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .failedToCreateURL: return "Faild to create URL"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .internetConecctionNotAvailable : return "Internet connection appears to be offline"
        }
    }
}

//Service method types
enum APIMethodType : String{
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
}

//Server types
enum APIServerType {
    case Development
    case Staging
    case Production
    var baseUrl:String {
        switch self {
        case .Development:
            return "https://dl.dropboxusercontent.com/"
        case .Staging:
            return "https://dl.dropboxusercontent.com/"
        case .Production:
            return "https://dl.dropboxusercontent.com/"
        }
    }
}



//Response Type
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

//Endpoints requirements
protocol APIEndPointProtocol {
    var path: String { get set }
    var method: APIMethodType  { get set }
    var parameter: Parameters?  { get set }
    var resultCompletion: ReesultComplitionBlock?  { get set }
}


//Endpoints details
class APIEndpoint :APIEndPointProtocol {
    var path: String = ""
    var method: APIMethodType
    var parameter: Parameters?
    var headers: HTTPHeaders?
    var resultCompletion: ReesultComplitionBlock?
    var showLoader: Bool = true
    
    init(path: String, method:APIMethodType  = .get, parameter: Parameters? = nil, showLoader: Bool = true ,headers:HTTPHeaders = APIManager.httpsHeaders(withtoken: nil),  completion: @escaping ReesultComplitionBlock) {
        self.path = path
        self.method = method
        self.parameter = parameter
        self.resultCompletion = completion
        self.showLoader = showLoader
        self.headers = headers
    }
}

class APIManager {
    
    static let shared = { APIManager() }()
    
    //Get deployement server type
    static var server :APIServerType {
        return .Development
    }
  
    //Get baseurl based on server type
    lazy var baseURL: String = {
        return APIManager.server.baseUrl
    }()
    
    
    //Set headers
    class func httpsHeaders(withtoken token: String?) -> HTTPHeaders {
        var httpHeaders = ["content-type": "application/json","accept": "application/json",]
        guard let authToken = token else {
            return httpHeaders
        }
        httpHeaders["Authorization"] = "Bearer \(authToken)"
        
        return httpHeaders
    }
}


