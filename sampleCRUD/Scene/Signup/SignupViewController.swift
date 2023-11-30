//
//  SignupViewController.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 27/11/23.
//

import Foundation
import UIKit

@available(iOS 15.0, *)
class SignupViewController: UIViewController {
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    let tfFullName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Full Name"
        return textField
    }()
    
    let tfEmail: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        return textField
    }()
    
    let tfPassword: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let tfConfirmPassword: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Confirm Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let btnNext: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        return btn
    }()
    
    let btnLogin: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Already have an acoount? Login Now", for: .normal)
        btn.setTitleColor(UIColor().convertColor(red: 255, green: 165, blue: 0, alpha: 1.0), for: .normal)
        btn.clipsToBounds = true
        return btn
    }()
    
    override func viewDidLoad() {
        scrollView.backgroundColor = .systemBackground
        title = "Sign Up"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor().convertColor(red: 255, green: 165, blue: 0, alpha: 1.0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .medium)]
        view.addSubview(scrollView)
        scrollView.addSubview(tfFullName)
        scrollView.addSubview(tfEmail)
        scrollView.addSubview(tfPassword)
        scrollView.addSubview(tfConfirmPassword)
        scrollView.addSubview(btnNext)
        scrollView.addSubview(btnLogin)
        setupConstraint()
        btnLogin.rx.tap.bind { (_) in
            self.navigationController?.popToRootViewController(animated: true)
        }.disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        tfFullName.addBottomBorder()
        tfEmail.addBottomBorder()
        tfPassword.addBottomBorder()
        tfConfirmPassword.addBottomBorder()
        btnNext.layer.cornerRadius = btnNext.frame.height / 2.0
        btnNext.applyGradient(colors: [UIColor.sandYellow.cgColor, UIColor.sandBottom.cgColor])
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tfFullName.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -160),
            tfFullName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tfFullName.heightAnchor.constraint(equalToConstant: 40),
            tfFullName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            tfFullName.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            
            tfEmail.topAnchor.constraint(equalTo: tfFullName.bottomAnchor, constant: 20),
            tfEmail.heightAnchor.constraint(equalToConstant: 40),
            tfEmail.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            tfEmail.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            
            tfPassword.topAnchor.constraint(equalTo: tfEmail.bottomAnchor, constant: 20),
            tfPassword.heightAnchor.constraint(equalToConstant: 40),
            tfPassword.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            tfPassword.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            
            tfConfirmPassword.topAnchor.constraint(equalTo: tfPassword.bottomAnchor, constant: 20),
            tfConfirmPassword.heightAnchor.constraint(equalToConstant: 40),
            tfConfirmPassword.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            tfConfirmPassword.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            
            btnNext.topAnchor.constraint(equalTo: tfConfirmPassword.bottomAnchor, constant: 120),
            btnNext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            btnNext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            btnNext.heightAnchor.constraint(equalToConstant: 50),
            
            btnLogin.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            btnLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
