//
//  ProofOfConceptView.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

// ProofOfConcept Module View Protocol
protocol  ProofOfConceptViewProtocol:class {
    var presenter:ProofOfConceptPresenter? {get set}
    var interactor:ProofOfConceptInteractor? {get set}
    var router:ProofOfConceptRouter? {get set}
    
    /// Update UI with value returned.
    // Set the view Object of Type NavBarTitileViewModel
    func presenter(navBarTitleViewModel:NavBarTitileViewModel)
    // Set the view Object of Type ProofOfConceptItemsViewModel
    func presenter(profOfConceptItmesViewModel:ProofOfConceptItemsViewModel)
}

/// ProofOfConcept Module View
class ProofOfConceptViewController: UIViewController {
    
    var presenter: ProofOfConceptPresenter?
    var interactor: ProofOfConceptInteractor?
    var router: ProofOfConceptRouter?
    
    private var items: [ProofConceptRow] = []
    
    // MARK: - Lifecycle Methods
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Informs the interactor that the View is ready to receive data.
        self.interactor?.viewDidLoad()
        
    }
    
}

// MARK: - extending ProofOfConceptViewController to implement it's protocol
extension ProofOfConceptViewController : ProofOfConceptViewProtocol {
    
    func presenter(profOfConceptItmesViewModel: ProofOfConceptItemsViewModel) {
        
    }
    
    func presenter(navBarTitleViewModel: NavBarTitileViewModel) {
        
    }
    
}


// MARK: - UITableView DataSource & Delegate
extension ProofOfConceptViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
