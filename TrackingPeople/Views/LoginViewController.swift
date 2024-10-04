//
//  LoginViewController.swift
//  TrackingPeople
//
//  Created by Jose David Bustos H on 28-09-19.
//

import UIKit

@available(iOS 11.0, *)
class LoginViewController: UIViewController {

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

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(showRegistration), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func loginUser() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Por favor, complete todos los campos.")
            return
        }

        let users = getSavedUsers()
        if let user = users.first(where: { $0.username == username && $0.password == password }) {
            print("Login successful for user: \(user.username)")
            gotoHome()
        } else {
            showAlert(message: "Usuario no encontrado.")
            //showAlert(message: "Usuario no encontrado")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.showRegistration()
//            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        alert.addAction(UIAlertAction(title: "Registrar", style: .default) { _ in
//            self.showRegistration()
//        })
        present(alert, animated: true)
    }

    @objc private func showRegistration() {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
    }

    @objc private func gotoHome() {
        print("Navigating to HomeViewController")
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }

    private func getSavedUsers() -> [Users] {
        guard let data = UserDefaults.standard.data(forKey: "usersList"),
              let savedUsers = try? JSONDecoder().decode([Users].self, from: data) else {
            return []
        }
        return savedUsers
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true  // Oculta el botón de regreso
    }
}
