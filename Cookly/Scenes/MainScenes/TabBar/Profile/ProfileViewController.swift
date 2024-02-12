//
//  ProfileViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//


import UIKit


final class ProfileViewController: UITableViewController {
    
    // MARK: - Properties
    @Injected(\.networkProvider) var apiManager: NetworkProviding
    @Injected(\.authViewModel) var viewModel: AuthenticationViewModel
    
    enum Section: Int, CaseIterable {
        case preferences, account, logout
    }
    
    weak var coordinator: Coordinator?
    
    // MARK: - Lifecycle
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
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
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section) {
        case .preferences: return "Preferences"
        case .account: return "Account"
        default: return " "
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        switch Section(rawValue: indexPath.section) {
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
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch Section(rawValue: indexPath.section) {
        case .preferences:
            presentColorPreferencesAlert()
        case .account:
            presentDeletionConfirmationAlert()
        default:
            performLogout()
        }
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
        return 30
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
                coordinator?.logoutUser()
            } catch {
                print("Error logout")
            }
        }
    }
    
    func deleteUserButtonTapped() {
        Task {
            do {
                try await viewModel.handleDeleteUserButtonTapped()
                coordinator?.logoutUser()
            } catch {
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


// MARK: - Preview
#Preview {
    let coordinator = FlowCoordinator(navigationController: UINavigationController())
    return ProfileViewController(coordinator: coordinator)
}
