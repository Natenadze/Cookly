//
//  ProfileVCViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.03.24.
//

import UIKit


final class ProfileViewModel {
    
    enum Section: Int, CaseIterable {
        case appInformation, preferences, account, logout
    }
    
    let sections = Section.allCases
    
    func titleForHeader(in section: Int) -> String {
        switch sections[section] {
        case .appInformation: return "App information"
        case .preferences: return "Preferences"
        case .account: return "Account"
        case .logout: return " "
        }
    }
    
    func configureCell(_ cell: UITableViewCell, for indexPath: IndexPath) {
           var content = cell.defaultContentConfiguration()
           
           switch Section(rawValue: indexPath.section) {
           case .appInformation:
               content.text = "Version"
               content.secondaryText = "0.1.0"
               content.prefersSideBySideTextAndSecondaryText = true
               content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 17)
               content.secondaryTextProperties.color = .systemGray
           case .preferences:
               content.text = "Color Preferences"
               cell.accessoryType = .disclosureIndicator
           case .account:
               content.text = "Delete Account"
               cell.accessoryType = .disclosureIndicator
           default:
               content.text = "Logout"
               content.textProperties.font = .boldSystemFont(ofSize: 18)
               content.textProperties.color = .red
               content.textProperties.alignment = .center
           }
           
           cell.contentConfiguration = content
       }
    
}

