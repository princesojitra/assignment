//
//  Endpoints.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

struct Endpoints {
   
    private struct Routes {
        static let ProofOfConceptsAPI = "s/" + apiKey
    }
    
    //MARK: ProofOfConcept API
    static var ProofOfConcepts: String {
        return Routes.ProofOfConceptsAPI + "/facts.json"
    }
}
