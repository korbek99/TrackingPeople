//
//  WelcomeViewController.swift
//  TrackingPeople
//
//  Created by Jose Preatorian on 03-10-24.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        // Crear una etiqueta de bienvenida
        let welcomeLabel = UILabel()
        welcomeLabel.text = "¡Bienvenido a la Aplicación!"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        // Crear un botón de continuar
        let continueButton = UIButton(type: .system)
        continueButton.setTitle("Continuar", for: .normal)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(continueButton)

        // Configurar restricciones
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),

            continueButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func continueTapped() {
        // Navegar a la siguiente vista (puedes cambiar esto a tu vista deseada)
        let nextViewController = HomeViewController() // Reemplaza con tu vista
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}






