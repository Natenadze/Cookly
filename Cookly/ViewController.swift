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
    private let apiManager: ApiManager
    
    // MARK: - Init
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
//        Task {
//            await apiManager.registerUser(email: "bondo@gm.com", password: "asdasdasdasdsa")
//        }
    }
    
}

