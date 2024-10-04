//
//  RegistrationViewController.swift
//  TrackingPeople
//
//  Created by Jose Preatorian on 03-10-24.
//
import UIKit

@available(iOS 11.0, *)
class RegistrationViewController: UIViewController {

    // UI Elements
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let lastnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(nameTextField)
        view.addSubview(lastnameTextField)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            lastnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            lastnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            usernameTextField.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func registerUser() {
        guard let name = nameTextField.text,
              let lastname = lastnameTextField.text,
              let username = usernameTextField.text,
              let password = passwordTextField.text else {
            // Handle empty fields
            return
        }

        let newUser = Users(id: UUID().hashValue, name: name, lastname: lastname, username: username, password: password)

        // Save to UserDefaults
        saveUser(user: newUser)

        print("Navigating to WelcomeViewController")
        let welcomeVC = WelcomeViewController()
        navigationController?.pushViewController(welcomeVC, animated: true)
    }

    private func saveUser(user: Users) {
        var savedUsers = getSavedUsers()
        savedUsers.append(user)
        
        let userData = try? JSONEncoder().encode(savedUsers)
        UserDefaults.standard.set(userData, forKey: "usersList")
    }

    private func getSavedUsers() -> [Users] {
        guard let data = UserDefaults.standard.data(forKey: "usersList"),
              let savedUsers = try? JSONDecoder().decode([Users].self, from: data) else {
            return []
        }
        return savedUsers
    }
}
