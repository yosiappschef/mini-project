//
//  HeaderBlankViewCell.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 07/11/23.
//

import Foundation
import UIKit

class HeaderBlankViewCell: UICollectionReusableView {
    //MARK: Properties
        
        static let headerIdentifier = "BlankHeaderView"
        
        lazy var header: UIView = {
            let f = UIView(frame: .zero)
            return f
        }()
        
        //MARK: Main LifeCycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(header)
//            setUpConstrains()
        }
        
        func setUpConstrains(){
            NSLayoutConstraint.activate([
                header.leadingAnchor.constraint(equalTo: leadingAnchor),
                header.trailingAnchor.constraint(equalTo: trailingAnchor),
                header.heightAnchor.constraint(equalToConstant: 2),
                header.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
}
