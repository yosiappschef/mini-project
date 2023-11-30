//
//  UIView+Extension.swift
//  sampleCRUD
//
//  Created by syndromme on 22/10/20.
//

import UIKit

extension UIView {
  static func nib<T: UIView>(withType type: T.Type) -> T {
      return Bundle.main.loadNibNamed(String(describing: type), owner: self, options: nil)?.first as! T
  }
    
    func setUp(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
    
    func setGradient(withColors colors: [CGColor] , startPoint: CGPoint , endPoint: CGPoint) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.insertSublayer(gradient, at: 0)
    }

}

extension UICollectionView {
   func reloadItems(inSection section:Int) {
      reloadItems(at: (0..<numberOfItems(inSection: section)).map {
         IndexPath(item: $0, section: section)
      })
   }
}
