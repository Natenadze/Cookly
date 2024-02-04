//
//  PromptViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 23.01.24.
//

import UIKit

class PromptViewController: UIViewController {
    
    let testJSON = Bundle.main.decode([Recipe].self, from: "test.json")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Under constr"
        
        for item in testJSON {
            print(item.name)
        }
    }
}



#Preview {
    PromptViewController()
}
