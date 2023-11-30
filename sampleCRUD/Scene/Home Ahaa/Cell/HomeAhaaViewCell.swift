//
//  HomeAhaaViewCell.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 30/11/23.
//

import Foundation
import UIKit

class HomeAhaaViewCell: UICollectionViewCell {
    static let cellIdentifier = "HomeAhaaViewCell"
    
    var cellData: HomeModelAhaa? {
        didSet {
            guard let cellData = cellData else {return}
            image.image = UIImage(named: cellData.image)
            label.text = cellData.text
        }
    }
    
    let image: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.clipsToBounds = true
        return i
    }()
    
    lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 8
        shadowView.layer.borderWidth = 0.6
        shadowView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        shadowView.layer.shadowColor = UIColor.label.withAlphaComponent(0.4).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 5
        return shadowView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure(){
        addSubview(shadowView)
        shadowView.addSubview(image)
        shadowView.addSubview(label)
        setupConstraint()
    }
    
    override func layoutMarginsDidChange() {
        label.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        label.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0)
        
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            image.topAnchor.constraint(equalTo: shadowView.topAnchor),
            image.bottomAnchor.constraint(equalTo: label.topAnchor),
            image.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor),
            label.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
//    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
            
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
            
        layoutAttributes.frame = frame
            
        return layoutAttributes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
