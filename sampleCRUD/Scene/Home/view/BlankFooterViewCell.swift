//
//  BlankFooterViewCell.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 02/11/23.
//

import Foundation
import UIKit

class BlankFooterViewCell : UICollectionReusableView {
    //MARK: Properties
        
        static let footerIdentifier = "BlankFooterView"
        
        lazy var footer: UIView = {
            let f = UIView(frame: .zero)
            return f
        }()
        
        //MARK: Main LifeCycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(footer)
//            setUpConstrains()
        }
        
        func setUpConstrains(){
            NSLayoutConstraint.activate([
                footer.leadingAnchor.constraint(equalTo: leadingAnchor),
                footer.trailingAnchor.constraint(equalTo: trailingAnchor),
                footer.heightAnchor.constraint(equalToConstant: 2),
                footer.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
}

