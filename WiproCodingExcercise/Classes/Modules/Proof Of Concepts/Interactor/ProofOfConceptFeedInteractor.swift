//
//  ProofOfConceptFeedInteractor.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

// ProofOfConcept Feed Module Interactor Protocol
protocol ProofOfConceptFeedInteractorProtocol:class {
    // The Interactor will inform the Service helper to fatch feeds data from server side and also  inform Presentor with proper outcome of the fatch result
    func fatchFeedsData(withLoader show:Bool)
}

// ProofOfConcept Feed Module Interactor 
class ProofOfConceptFeedInteractor: ProofOfConceptFeedInteractorProtocol {
  
    private let service : ProofOfConceptFeedServiceProtocol?
    var presenter : ProofOfConceptFeedPresenter?
    private var profocConcept:ProofConceptFeedModel?
    
    required init(withService profOfConcept:ProofOfConceptFeedServiceProtocol ) {
        self.service = profOfConcept
    }
    
    func fatchFeedsData(withLoader show :Bool) {
        self.service?.getProofOfConeptsFeeds(withLoader: show, completionHandler: { (result) in
            switch result {
            case .failure(let error):
                self.presenter?.interactor(self, didRetriveFailProofOfConcpet: error)
                
            case .success(let objects):
                guard let prrofOfConceptResult = objects as? ProofConceptFeedModel else {
                    self.presenter?.interactor(self, didRetriveFailProofOfConcpet: .jsonParsingFailure)
                    return
                }
                self.profocConcept = prrofOfConceptResult
                self.presenter?.interactor(self, didRetriveProofOfConcpet: self.profocConcept!)
            }
        })
    }
}
