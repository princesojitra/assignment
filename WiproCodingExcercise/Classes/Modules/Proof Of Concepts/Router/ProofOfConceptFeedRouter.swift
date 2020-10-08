//
//  ProofOfConceptFeedRouter.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

protocol  ProofOfConceptFeedRouterProtocol:class {
    var navigationController:UINavigationController? {get}
    func routeToDetail()
}

class ProofOfConceptFeedRouter: ProofOfConceptFeedRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    func routeToDetail(){
    }
}
