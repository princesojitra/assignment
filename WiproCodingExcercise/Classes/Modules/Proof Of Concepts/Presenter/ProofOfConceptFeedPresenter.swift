//
//  ProofOfCOnceptPresenter.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

// ProofOfConcept Feed Module Presenter Protocol
protocol  ProofOfConceptFeedPresenterProtocol:class {
    // The Interactor will inform the Presenter a successful fetch.
    func interactor(_ interactor: ProofOfConceptFeedInteractor,didRetriveProofOfConcpet profOfConcept:ProofConceptFeedModel)
    // The Interactor will inform the Presenter a failed fetch.
    func interactor(_ interactor: ProofOfConceptFeedInteractor,didRetriveFailProofOfConcpet error:APIError)
}


// NavigationBar Title View Model
struct NavBarTitileViewModel {
    var title:String
}

// ProofOfConcept Feed View Model
struct ProofOfConceptItemsViewModel {
    var items:[ProofConceptRow]
}

// ProofOfConcept Feed Module Presenter
class ProofOfConceptFeedPresenter {
    weak var viewController: ProofOfConceptFeedViewProtocol?
}

// MARK: - extending ProofOfConceptFeedPresenter to implement it's protocol
extension ProofOfConceptFeedPresenter :ProofOfConceptFeedPresenterProtocol {
    
    func interactor(_ interactor: ProofOfConceptFeedInteractor, didRetriveFailProofOfConcpet error: APIError) {
        
        self.viewController?.presenter(navBarTitleViewModel: NavBarTitileViewModel(title: ""))
        self.viewController?.presenter(profOfConceptItmesViewModel: ProofOfConceptItemsViewModel(items: [ProofConceptRow]()))
    }
    
    func interactor(_ interactor: ProofOfConceptFeedInteractor, didRetriveProofOfConcpet profOfConcept: ProofConceptFeedModel) {
        
        let navbarTitleViewModel = NavBarTitileViewModel(title: profOfConcept.title ?? "")
        self.viewController?.presenter(navBarTitleViewModel: navbarTitleViewModel)
        
        guard let profOfConceptItems = profOfConcept.rows else {
            self.viewController?.presenter(profOfConceptItmesViewModel: ProofOfConceptItemsViewModel(items: [ProofConceptRow]()))
            return
        }
        
        self.viewController?.presenter(profOfConceptItmesViewModel: ProofOfConceptItemsViewModel(items: profOfConceptItems))
        
    }
}
