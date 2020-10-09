//
//  ProofOfConceptFeedInteractor.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

// ProofOfConcept Feed Module Interactor Protocol
protocol ProofOfConceptFeedInteractorProtocol:class {
    // The Interactor will inform the Service helper to fetch feeds data from server side and also  inform Presentor with proper outcome of the fetch result
    func fetchFeedsData(withLoader show:Bool)
}

// ProofOfConcept Feed Module Interactor 
class ProofOfConceptFeedInteractor: ProofOfConceptFeedInteractorProtocol {
  
    private let service : ProofOfConceptFeedServiceProtocol?
    var presenter : ProofOfConceptFeedPresenterProtocol?
    private var profocConcept:ProofConceptFeedModel?
    
    required init(withService profOfConcept:ProofOfConceptFeedServiceProtocol ) {
        self.service = profOfConcept
    }
    
    func fetchFeedsData(withLoader show :Bool) {
        self.service?.getProofOfConeptsFeeds(withLoader: show, completionHandler: { (result) in
            switch result {
            case .failure(let error):
                self.presenter?.interactor(didRetriveFailProofOfConcpet: error)
                
            case .success(let objects):
                guard let prrofOfConceptResult = objects as? ProofConceptFeedModel else {
                    self.presenter?.interactor(didRetriveFailProofOfConcpet: .jsonParsingFailure)
                    return
                }
                self.profocConcept = prrofOfConceptResult
                self.presenter?.interactor(didRetriveProofOfConcpet: self.profocConcept!)
            }
        })
    }
}
