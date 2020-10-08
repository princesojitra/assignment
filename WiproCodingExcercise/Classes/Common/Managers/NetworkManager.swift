//
//  NetworkManager.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit
import Reachability

class NetworkManager {
    static let shared = NetworkManager()
    let reachability = try! Reachability()
    
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .unavailable:
            print("Network not reachable")
        case .none:
            print("Network not available")
        }
    }
    
    func isReachableNetwork() -> Bool {
        switch reachability.connection {
        case .wifi, .cellular:
            return true
        case .unavailable, .none:
            return false
        }
    }
}


