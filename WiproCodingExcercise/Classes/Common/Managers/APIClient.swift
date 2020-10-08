//
//  APIClient.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 07/10/20.
//

import UIKit

class APIClient: NSObject {
    
    private let urlSession = URLSession.shared
    
    // Fetch data from the server with dynamic codeable model
    func request<T:APIEndpoint,U:Decodable>(withEndpoint endpoint:T, decodingType:U.Type?) {
        
        print("******* API Log ******")
        print("URL : ", endpoint.path)
        print("Method : ", endpoint.method.rawValue)
        print("Params : ", endpoint.parameter ?? [:])
        print("Headers : ", endpoint.headers ?? [:])
        
        
        // Session request with endpoint details
        if NetworkManager.shared.isReachableNetwork() {
            if endpoint.showLoader {
                indicator?.startAnimating()
            }
            
            guard let url = URL(string:endpoint.path) else {
                endpoint.resultCompletion?(.failure(.failedToCreateURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            request.allHTTPHeaderFields = endpoint.headers
            
            
            //Check if web service params can be serialize or not before api call
            if endpoint.method == .post {
                if let paramaters = endpoint.parameter {
                    let jsonBody: Data
                    do {
                        jsonBody = try JSONSerialization.data(withJSONObject: paramaters, options: [])
                        request.httpBody = jsonBody
                    } catch {
                        print("Error: cannot create JSON from todo")
                        endpoint.resultCompletion?(.failure(.jsonParsingFailure))
                        return
                    }
                }
            }
            
            urlSession.dataTask(with: request) { (data, response
                                                  , error) in
                if endpoint.showLoader {
                    DispatchQueue.main.async {
                        indicator?.stopAnimating()
                    }
                }
                
                guard error == nil else {
                    endpoint.resultCompletion?(.failure(.requestFailed))
                    return
                }
                
                guard let data = data, String(decoding: data, as: UTF8.self) != ""  else {
                    endpoint.resultCompletion?(.failure(.invalidData))
                    return
                }
                
                
                let jsonString = String(decoding: data, as: UTF8.self)
                guard let jsonData = jsonString.data(using: .utf8) else {
                    endpoint.resultCompletion?(.failure(.jsonParsingFailure))
                    return
                }
                
                guard let decodeType = decodingType else {
                    endpoint.resultCompletion?(.failure(.invalidData))
                    return
                }
                
                guard let genricResponseModel =  self.decodeResponse(dataToDeocde: jsonData, decodingType: decodeType) else {
                    endpoint.resultCompletion?(.failure(.invalidData))
                    return
                }
                
                endpoint.resultCompletion?(.success(genricResponseModel))
                print("******* API Log ******")
                
            }.resume()
        } else {
            endpoint.resultCompletion?(.failure(.internetConecctionNotAvailable))
            print("******* API Log ******")
        }
    }
    
    // Decode data into specified datamodel
    func decodeResponse<T:Decodable>(dataToDeocde:Data,decodingType:T.Type) -> T? {
        do {
            let genericModel = try JSONDecoder().decode(decodingType, from: dataToDeocde)
            return genericModel
        } catch {
            return nil
        }
    }
    
}
