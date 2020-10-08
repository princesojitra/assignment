//
//  ProofOfConceptFeedView.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

// ProofOfConcept Module View Protocol
protocol  ProofOfConceptFeedViewProtocol:class {
    var presenter:ProofOfConceptFeedPresenter? {get set}
    var interactor:ProofOfConceptFeedInteractor? {get set}
    var router:ProofOfConceptFeedRouter? {get set}
    
    /// Update UI with value returned.
    // Set the view Object of Type NavBarTitileViewModel
    func presenter(navBarTitleViewModel:NavBarTitileViewModel)
    // Set the view Object of Type ProofOfConceptItemsViewModel
    func presenter(profOfConceptItmesViewModel:ProofOfConceptItemsViewModel)
}

/// ProofOfConcept Module View
class ProofOfConceptFeedViewController: UIViewController {
    
    var presenter: ProofOfConceptFeedPresenter?
    var interactor: ProofOfConceptFeedInteractor?
    var router: ProofOfConceptFeedRouter?
    var profOfConceptView: ProofOfConceptFeedView?
    
    private var items: [ProofConceptRow] = []
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        super.loadView()
        self.view = profOfConceptView
        profOfConceptView?.tableView.delegate = self
        profOfConceptView?.tableView.dataSource = self
        profOfConceptView?.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.profOfConceptView?.tableView.alpha = 0.0
        self.profOfConceptView?.hidePlaceholder()
        // Informs the interactor that the View is ready to receive data.
        self.interactor?.fatchFeedsData(withLoader: true)
        
    }
}

// MARK: - extending ProofOfConceptFeedViewController to implement it's protocol
extension ProofOfConceptFeedViewController : ProofOfConceptFeedViewProtocol {
    
    func presenter(profOfConceptItmesViewModel: ProofOfConceptItemsViewModel) {
        DispatchQueue.main.async {
            self.profOfConceptView?.stopLoaderWithEndRefreshing()
            self.items = profOfConceptItmesViewModel.items
            if self.items.count > 0 {
                self.profOfConceptView?.tableView.alpha = 1.0
                self.profOfConceptView?.hidePlaceholder()
            }
            self.profOfConceptView?.tableView.reloadData()
        }
    }
    
    func presenter(navBarTitleViewModel: NavBarTitileViewModel) {
        DispatchQueue.main.async {
            self.profOfConceptView?.stopLoaderWithEndRefreshing()
            self.navigationItem.title = navBarTitleViewModel.title
        }
        
    }
    
}
// MARK: - Action Methods
extension ProofOfConceptFeedViewController {
@objc func refreshData(_ refreshControl: UIRefreshControl) {
    self.view.endEditing(true)
    self.interactor?.fatchFeedsData(withLoader: false)
    
    }
}
    
// MARK: - UITableView DataSource & Delegate
extension ProofOfConceptFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: TblCellIdentifier.ProfOfConceptFeedList) as! ProofOfConceptTableCell
        
        let proofConceptRowModel = self.items[indexPath.row]
        cell.proofConceptRowModel = proofConceptRowModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
