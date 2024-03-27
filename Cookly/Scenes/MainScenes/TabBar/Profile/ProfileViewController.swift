//
//  ProfileViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//


import UIKit


final class ProfileViewController: UITableViewController {
    
    // MARK: - Properties
    let viewModel: ProfileViewModel
    
    
    // MARK: - LifeCycle
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .singleLine
    }
    
}

// MARK: - Extensions
extension ProfileViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleForHeader(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        viewModel.configureCell(cell, for: indexPath)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch viewModel.sections[indexPath.section] {
        case .appInformation: break
        case .preferences:
            presentColorPreferencesAlert()
        case .account:
            presentDeletionConfirmationAlert()
        default:
            performLogout()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .gray
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
}

// MARK: - Actions
private extension ProfileViewController {
    
    func changeColorScheme(to scheme: UIUserInterfaceStyle) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.forEach { window in
            window.overrideUserInterfaceStyle = scheme
        }
    }
    
    func presentColorPreferencesAlert() {
        let alertController = UIAlertController(title: "", message: "Choose a theme", preferredStyle: .actionSheet)
        
        let lightAction = UIAlertAction(title: "Light", style: .default) { [weak self] _ in
            self?.changeColorScheme(to: .light)
        }
        let darkAction = UIAlertAction(title: "Dark", style: .default) { [weak self] _ in
            self?.changeColorScheme(to: .dark)
        }
        let systemAction = UIAlertAction(title: "System Default", style: .default) { [weak self] _ in
            self?.changeColorScheme(to: .unspecified)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(lightAction)
        alertController.addAction(darkAction)
        alertController.addAction(systemAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    func performLogout() {
        Task {
            do {
                try await viewModel.signOut()
                viewModel.coordinator?.logoutUser()
            } catch {
                print("Error logout")
            }
        }
    }
    
    func deleteUserButtonTapped() {
        Task {
            do {
                try await viewModel.handleDeleteUserButtonTapped()
                viewModel.coordinator?.logoutUser()
            } catch {
                //TODO: - ???
                print("Error delete user")
            }
        }
    }
    
    func presentDeletionConfirmationAlert() {
        let alertController = UIAlertController(
            title: "Delete Account",
            message: "Are you sure you want to delete your account? This action cannot be undone.",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteUserButtonTapped()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}


