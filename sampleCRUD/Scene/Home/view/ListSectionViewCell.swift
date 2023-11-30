//
//  ListSectionViewCell.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 07/11/23.
//

import Foundation
import UIKit

protocol DeleteCell: AnyObject {
    func onClickDelete(indexPath: IndexPath)
}

class ListSectionViewCell: UICollectionViewCell {
    
    // MARK: PROPERTIES -
    static let cellIdentifier = "ListCollectionViewCell"
    
    var cellData: BannerModel? {
        didSet {
            guard let cellData = cellData else { return }
            restaurantImage.image = UIImage(named: cellData.image)
        }
    }
    
    let restaurantImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        return img
    }()
    
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Restaurant Name"
        l.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        l.textColor = .label
        l.textAlignment = .left
        l.backgroundColor = .red
        return l
    }()
    
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Subtitle"
        l.textColor = .label
        return l
    }()
    
    let dividerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.gray.cgColor
        return v
    }()
    
//    let subtitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "North India, Punjabi"
//        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
//        l.textColor = .gray
//        l.textAlignment = .center
//        l.numberOfLines = 0
//        return l
//    }()
    
    // MARK: MAIN -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
//        backgroundColor = .blue
        addSubview(restaurantImage)
        addSubview(title)
        addSubview(dividerView)
        addSubview(subtitle)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            print(self.frame.size.width)
//        }
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            restaurantImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            restaurantImage.widthAnchor.constraint(equalToConstant: 120),
            restaurantImage.topAnchor.constraint(equalTo: topAnchor),
//            restaurantImage.heightAnchor.constraint(equalToConstant: 180),
            restaurantImage.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: -20),
            
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.leadingAnchor.constraint(equalTo: restaurantImage.trailingAnchor, constant: 10),
            
            subtitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitle.leadingAnchor.constraint(equalTo: restaurantImage.trailingAnchor, constant: 10),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
            
            
//            title.centerXAnchor.constraint(equalTo: centerXAnchor),
//            title.topAnchor.constraint(equalTo: restaurantImage.bottomAnchor, constant: 30),
//            title.leadingAnchor.constraint(equalTo: leadingAnchor),
//            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            
//            dividerView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            dividerView.widthAnchor.constraint(equalToConstant: 30),
//            dividerView.heightAnchor.constraint(equalToConstant: 1),
//            dividerView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            
//            subtitle.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 15),
//            subtitle.centerXAnchor.constraint(equalTo: centerXAnchor),
//            subtitle.leadingAnchor.constraint(equalTo: leadingAnchor),
//            subtitle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
}
