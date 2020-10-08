//
//  ProofOfConceptBuilder.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 07/10/20.
//

import UIKit

class ProofOfConceptConfigurator {

   static func configureModule(viewController : ProofOfConceptViewController) {
        //MARK: Initialise components.
        
        let interactor = ProofOfConceptInteractor(withService: ProofOfConceptService())
        let presenter = ProofOfConceptPresenter()
        let router = ProofOfConceptRouter()
        
        //MARK: link VIP components.
        
        viewController.interactor = interactor
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.navigationController = viewController.navigationController
        
    }
    
}
