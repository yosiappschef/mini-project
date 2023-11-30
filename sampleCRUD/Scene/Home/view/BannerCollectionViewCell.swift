//
//  BannerCollectionViewCell.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 01/11/23.
//

import Foundation
import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "BannerCollectionViewCell"
        
        var cellData : BannerModel? {
            didSet {
                guard let cellData = cellData else {return}
                bannerImage.image = UIImage(named: cellData.image)
            }
        }
        
        lazy var shadowView: UIView = {
            let shadowView = UIView()
            shadowView.translatesAutoresizingMaskIntoConstraints = false
            shadowView.backgroundColor = .green
            shadowView.layer.cornerRadius = 8
            shadowView.layer.borderWidth = 0.6
            shadowView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
            shadowView.layer.shadowColor = UIColor.label.withAlphaComponent(0.4).cgColor
            shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
            shadowView.layer.shadowOpacity = 1
            shadowView.layer.shadowRadius = 5
            return shadowView
        }()
        
        let bannerImage : UIImageView = {
            let bI = UIImageView()
            bI.translatesAutoresizingMaskIntoConstraints = false
            bI.backgroundColor = .systemBackground
            bI.clipsToBounds = true
            bI.contentMode = .scaleAspectFill
            bI.layer.cornerRadius = 8
            return bI
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        func configure(){
            contentView.backgroundColor = .clear
            addSubview(shadowView)
            shadowView.addSubview(bannerImage)
            shadowView.setUp(to: self)
            bannerImage.setUp(to: shadowView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
