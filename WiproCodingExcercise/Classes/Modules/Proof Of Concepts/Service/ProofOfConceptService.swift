//
//  PhotosService.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

protocol  ProofOfConceptServiceProtocol:class {
    func getProofOfConepts(completionHandler: @escaping ReesultComplitionBlock)
}

class ProofOfConceptService: ProofOfConceptServiceProtocol {
    
    static let shared = { ProofOfConceptService() }()
    let apiClient = APIClient()
    
    
    //Get ProofOfConcepts from server
    func getProofOfConepts(completionHandler: @escaping ReesultComplitionBlock){
        activityIndicator()
        let endPointPath = configureEndointPath(withPath: Endpoints.ProofOfConcepts)
        let endpointProofOfConcept = APIEndpoint(path: endPointPath, method: .get,completion: completionHandler)
        apiClient.request(withEndpoint: endpointProofOfConcept, decodingType: ProofConceptModel.self)
    }
    
    func configureEndointPath(withPath path:String) -> String {
        return "\(APIManager.shared.baseURL)\(path)"
    }
    
}
