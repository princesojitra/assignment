//
//  ProofOfConceptBuilder.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

class ProofOfConceptConfigurator {
    
    static func configureModule(viewController : ProofOfConceptViewController) {
        
        //MARK: Initialise components.
        let view = ProofOfConceptView()
        let interactor = ProofOfConceptInteractor(withService: ProofOfConceptService())
        let presenter = ProofOfConceptPresenter()
        let router = ProofOfConceptRouter()
        
        //MARK: link VIP components.
        viewController.profOfConceptView = view
        viewController.interactor = interactor
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.navigationController = viewController.navigationController
        
    }
    
}
