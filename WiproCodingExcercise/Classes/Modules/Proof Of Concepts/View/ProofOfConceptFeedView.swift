//
//  ProofOfConceptFeedView.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit

class ProofOfConceptFeedView: UIView {
    
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
   
    public func showRetryButton() {
        UIView.animate(withDuration: 0.3) {
            self.retryButon.alpha = 1.0
        }
    }
    
    public func hideRetryButton() {
        UIView.animate(withDuration: 0.3) {
            self.retryButon.alpha = 0.0
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
    
    lazy var retryButon: UIButton = {
        let btn = UIButton()
        btn.setTitle("Retry", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 10.0
        btn.layer.borderWidth = 5.0
        btn.clipsToBounds = true
        btn.isUserInteractionEnabled = true
        btn.layer.borderColor = UIColor.white.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()

}

// MARK: - UI Setup
extension ProofOfConceptFeedView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.backgroundColor = .white
        
        self.addSubview(tableView)
        self.addSubview(placeholderLabel)
        self.addSubview(retryButon)
        
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
        
        NSLayoutConstraint.activate([
            retryButon.centerXAnchor.constraint(equalTo: self.placeholderLabel.centerXAnchor),
            retryButon.topAnchor.constraint(equalTo: self.placeholderLabel.bottomAnchor,constant: 10.0),
            retryButon.widthAnchor.constraint(equalToConstant: 80.0),
            retryButon.heightAnchor.constraint(equalToConstant: 40.0)
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
