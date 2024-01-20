//
//  ViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 19.01.24.
//

import UIKit
import Supabase

final class ViewController: UIViewController {
    
    // MARK: - Properties
    @Injected(\.networkProvider) var apiManager: NetworkProviding
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
//        Task {
//            await apiManager.register(email: "depe@nd.com", password: "asdasdasdasdsa")
//        } 
        
        Task {
            await apiManager.login(email: "depe@nd.com", password: "asdasdasdasdsa")
        }
    }
    
}

