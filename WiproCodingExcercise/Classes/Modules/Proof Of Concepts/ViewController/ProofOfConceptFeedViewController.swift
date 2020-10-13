//
//  ProofOfConceptFeedView.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit
import Reachability

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
    // Set the view for internet connection error
    func presenterInternetConnectionError()
    
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
        profOfConceptView?.retryButon.addTarget(self, action: #selector(internetConectionError(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.profOfConceptView?.tableView.alpha = 0.0
        self.profOfConceptView?.hidePlaceholder()
        self.profOfConceptView?.hideRetryButton()
        // Informs the interactor that the View is ready to receive data.
        self.interactor?.fetchFeedsData(withLoader: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: NetworkManager.shared.reachability)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: NetworkManager.shared.reachability)
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
                self.profOfConceptView?.hideRetryButton()
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
    
    func presenterInternetConnectionError() {
        self.profOfConceptView?.tableView.alpha = 0.0
        self.profOfConceptView?.placeholderLabel.text = "Internet connection appears to be offline."
        self.profOfConceptView?.showPlaceholder()
        self.profOfConceptView?.showRetryButton()
    }
    
    func displayRefreshedFeeds(){
        self.view.endEditing(true)
        self.profOfConceptView?.hidePlaceholder()
        self.profOfConceptView?.hideRetryButton()
        self.interactor?.fetchFeedsData(withLoader: true)
    }
    
}
// MARK: - Action Methods
extension ProofOfConceptFeedViewController {
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        self.view.endEditing(true)
        self.profOfConceptView?.hidePlaceholder()
        self.profOfConceptView?.hideRetryButton()
        self.interactor?.fetchFeedsData(withLoader: false)
        
    }
    
    @objc func internetConectionError(_ retryButton: UIButton) {
        self.displayRefreshedFeeds()
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            self.displayRefreshedFeeds()
        case .cellular:
            print("Reachable via Cellular")
            self.displayRefreshedFeeds()
        case .unavailable:
            print("Network not reachable")
        case .none:
            print("Network not available")
        }
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
