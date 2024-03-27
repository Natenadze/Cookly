//
//  ProfileVCViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.03.24.
//

import UIKit


final class ProfileViewModel {
    
    @Injected(\.userService) var userService: UserServiceProviding
    weak var coordinator: Coordinator?
    
    enum Section: Int, CaseIterable {
        case preferences, account, appInformation, logout
    }
    
    let sections = Section.allCases
    
    // MARK: - LifeCycle
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func signOut() async throws {
        do {
            try await userService.signOut()
        } catch {
            throw AuthError.serverError
        }
    }
    
    func handleDeleteUserButtonTapped() async throws {
        do {
            try await userService.deleteUser()
        } catch {
            throw AuthError.serverError
        }
    }
    
    
    
    func titleForHeader(in section: Int) -> String {
        switch sections[section] {
        case .preferences: return "Preferences"
        case .account: return "Account"
        case .appInformation: return "App information"
        case .logout: return " "
        }
    }
    
    func configureCell(_ cell: UITableViewCell, for indexPath: IndexPath) {
        var content = cell.defaultContentConfiguration()
        
        switch Section(rawValue: indexPath.section) {
        case .preferences:
            content.text = "Color Preferences"
            cell.accessoryType = .disclosureIndicator
        case .account:
            content.text = "Delete Account"
            cell.accessoryType = .disclosureIndicator
        case .appInformation:
            content.text = "Version"
            content.secondaryText = "0.1.0"
            content.prefersSideBySideTextAndSecondaryText = true
            content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 17)
            content.secondaryTextProperties.color = .systemGray
        default:
            content.text = "Logout"
            content.textProperties.font = .boldSystemFont(ofSize: 18)
            content.textProperties.color = .red
            content.textProperties.alignment = .center
        }
        cell.contentConfiguration = content
    }
}
