//
//  PhotosService.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

// ProofOfConcept Feed Service Helper Protocol
protocol  ProofOfConceptServiceProtocol:class {
    func getProofOfConeptsFeeds(withLoader show:Bool,completionHandler: @escaping ReesultComplitionBlock)
}

// ProofOfConcept Feed Service Helper Module 
class ProofOfConceptService: ProofOfConceptServiceProtocol {
    
    
    static let shared = { ProofOfConceptService() }()
    let apiClient = APIClient()
    
    //Get ProofOfConcepts from server
    func getProofOfConeptsFeeds(withLoader show: Bool, completionHandler: @escaping ReesultComplitionBlock) {
        if show {
            activityIndicator()
        }
        let endPointPath = configureEndointPath(withPath: Endpoints.ProofOfConcepts)
        let endpointProofOfConcept = APIEndpoint(path: endPointPath, method: .get,showLoader: show,completion: completionHandler)
        apiClient.request(withEndpoint: endpointProofOfConcept, decodingType: ProofConceptFeedModel.self)
    }
    
    
    func configureEndointPath(withPath path:String) -> String {
        return "\(APIManager.shared.baseURL)\(path)"
    }
    
}
