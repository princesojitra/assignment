//
//  ProofOfConceptBuilder.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

class ProofOfConceptFeedConfigurator {
    
    static func configureModule(viewController : ProofOfConceptFeedViewController) {
        
        //MARK: Initialise components.
        let view = ProofOfConceptFeedView()
        let interactor = ProofOfConceptFeedInteractor(withService: ProofOfConceptFeedService())
        let presenter = ProofOfConceptFeedPresenter()
        let router = ProofOfConceptFeedRouter()
        
        //MARK: link VIP components.
        viewController.profOfConceptView = view
        viewController.interactor = interactor
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.navigationController = viewController.navigationController
        
    }
    
}
