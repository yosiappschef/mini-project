//
//  SplashScreenViewCell.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 23/11/23.
//

import Foundation
import UIKit

class SplashScreenViewCell: UICollectionViewCell {
    static let cellIdentifier = "SplashScreenViewCell"
    static let textColor = UIColor().convertColor(red: 141, green: 141, blue: 141, alpha: 1.0)
    
    var cellData: SplashModel? {
        didSet {
            guard let cellData = cellData else {return}
            image.image = UIImage(named: cellData.image)
            textLogo.image = UIImage(named: cellData.textLogo)
            label.text = cellData.label
        }
    }
    
    let button: UIButton = {
       let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.clipsToBounds = true
        b.setTitle("Finish", for: .normal)
        b.applyGradient(colors: [UIColor.sandYellow.cgColor, UIColor.sandBottom.cgColor])
        return b
    }()
    
    let image: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.clipsToBounds = true
        return i
    }()
    
    let textLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .light)
        label.textColor = textColor
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure(){
        addSubview(image)
//        addSubview(textLogo)
        addSubview(label)
        addSubview(button)
        setupConstraint()
    }
    
    func buttonVisibility(isVisible: Bool){
        button.isHidden = !isVisible
        self.layoutIfNeeded()
    }
    
    func imageVisibility(isVisible: Bool){
        image.isHidden = !isVisible
        image.heightAnchor.constraint(equalToConstant: isVisible ? 100:0).isActive = true
//        textLogo.heightAnchor.constraint(equalToConstant: isVisible ? 50:0).isActive = true
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        button.layer.cornerRadius = button.frame.height / 2.0
        button.applyGradient(colors: [UIColor.sandYellow.cgColor, UIColor.sandBottom.cgColor])
        
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
//            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
            
//            textLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
//            textLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
//            textLogo.widthAnchor.constraint(equalToConstant: 100),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
//            button.trailingAnchor.constraint(equalTo: trailingAnchor),
//            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UIButton {
    func applyGradient(colors: [CGColor])
        {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
}

extension UICollectionViewCell {
    func applyGradient(colors: [CGColor])
        {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
}

extension UIColor {
    func convertColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    static let sandYellow = UIColor(red: 251.0 / 255.0, green: 218.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0)
    static let sandBottom = UIColor(red: 247.0 / 255.0, green: 107.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
}
