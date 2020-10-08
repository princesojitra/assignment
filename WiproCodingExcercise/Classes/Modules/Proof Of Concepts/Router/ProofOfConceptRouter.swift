//
//  ProofOfConceptRouter.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit
protocol  ProofOfConceptRouterProtocol:class {
    var navigationController:UINavigationController? {get}
    func routeToDetail(with id: String)
}

class ProofOfConceptRouter: ProofOfConceptRouterProtocol {

   weak var navigationController: UINavigationController?
    
    func routeToDetail(with id: String) {
        
    }
}
