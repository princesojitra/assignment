//
//  ProofOfConceptView.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

class ProofOfConceptView: UIView {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    public func showPlaceholder() {
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.alpha = 1.0
        }
    }
    
    public func hidePlaceholder() {
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.alpha = 0.0
        }
    }
    
    public func reloadTableView() {
        self.tableView.reloadData()
    }
    
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 90
        tableView.register(ProofOfConceptTableCell.self, forCellReuseIdentifier: TblCellIdentifier.ProfOfConceptFeedList)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        return tableView
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "No items found."
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()

}

// MARK: - UI Setup
extension ProofOfConceptView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.backgroundColor = .white
        
        self.addSubview(tableView)
        self.addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    // Stop Refresh control
    public func stopLoaderWithEndRefreshing(){
        DispatchQueue.main.async {  [weak self] in
            indicator?.stopAnimating()
            guard let strongSelf = self else { return }
            if strongSelf.refreshControl.isRefreshing {
                strongSelf.refreshControl.endRefreshing()
            } else if !strongSelf.refreshControl.isHidden {
                strongSelf.refreshControl.beginRefreshing()
                strongSelf.refreshControl.endRefreshing()
            }
        }
    }
      
}
