//
//  LoginViewController.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 27/11/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let imageLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "splash_2")
        image.clipsToBounds = true
        return image
    }()
    
    let imageText: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "textlogo")
        image.clipsToBounds = true
        return image
    }()
    
    let tfEmail: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email Or Phone Number"
        return textField
    }()
    
    let tfPassword: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    let forgotPassword: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(UIColor().convertColor(red: 255, green: 165, blue: 0, alpha: 1.0), for: .normal)
        return button
    }()
    
    let btnlogin: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        return btn
    }()
    
    let btnRegister: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("New member? Sign Up Now", for: .normal)
        btn.setTitleColor(UIColor().convertColor(red: 255, green: 165, blue: 0, alpha: 1.0), for: .normal)
        btn.clipsToBounds = true
        return btn
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageLogo)
        view.addSubview(imageText)
        view.addSubview(tfEmail)
        view.addSubview(tfPassword)
        view.addSubview(forgotPassword)
        view.addSubview(btnlogin)
        view.addSubview(btnRegister)
        
        if #available(iOS 15.0, *) {
            btnRegister.rx.tap.bind { (_) in
                self.navigationController?.pushViewController(SignupViewController(), animated: true)
            }.disposed(by: disposeBag)
        } else {
            // Fallback on earlier versions
        }
        btnlogin.rx.tap.bind { (_) in
            let vc = HomeTabController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
        }.disposed(by: disposeBag)
        setupConstraint()
    }
    
    override func viewDidLayoutSubviews() {
        btnlogin.layer.cornerRadius = btnlogin.frame.height / 2.0
        btnlogin.applyGradient(colors: [UIColor.sandYellow.cgColor, UIColor.sandBottom.cgColor])
//        btnRegister.applyGradient(colors: [UIColor.sandYellow.cgColor, UIColor.sandBottom.cgColor])
        tfEmail.addBottomBorder()
        tfPassword.addBottomBorder()
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
//            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            imageLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogo.heightAnchor.constraint(equalToConstant: 80),
            imageLogo.widthAnchor.constraint(equalToConstant: 80),
            
            imageText.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 20),
//            imageText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            imageText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageText.heightAnchor.constraint(equalToConstant: 40),
            imageText.widthAnchor.constraint(equalToConstant: 60),
            
            tfEmail.topAnchor.constraint(equalTo: imageText.bottomAnchor, constant: 50),
            tfEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            tfEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            tfEmail.heightAnchor.constraint(equalToConstant: 40),
            
            tfPassword.topAnchor.constraint(equalTo: tfEmail.bottomAnchor, constant: 20),
            tfPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            tfPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            tfPassword.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPassword.topAnchor.constraint(equalTo: tfPassword.bottomAnchor, constant: 20),
            forgotPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            btnlogin.topAnchor.constraint(equalTo: forgotPassword.bottomAnchor, constant: 80),
            btnlogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            btnlogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            btnlogin.heightAnchor.constraint(equalToConstant: 50),
            
            btnRegister.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            btnRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor().convertColor(red: 141, green: 141, blue: 141, alpha: 1.0).cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
