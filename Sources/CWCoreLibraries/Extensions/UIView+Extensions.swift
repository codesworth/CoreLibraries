//
//  UIView+Extensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 19/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit


extension UIView{
    
    public func pinAllSides()->[NSLayoutConstraint]{
        guard let superview = superview else {fatalError("Pinning must be done in a superview")}
        return [
            topAnchor.constraint(equalTo: superview.topAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
    }
    
    
    public func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    
    public func layout(_ invalidatePrevious:Bool = false,using closure:(LayoutProxy) -> Void){
        if invalidatePrevious{removeConstraints(self.constraints)}
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view:self))
    }
}


extension CALayer{
    
    
    public func roundCorners(_ corners: CACornerMask?, radius:CGFloat) {
        guard let corners = corners else{
            //cornerRadius = radius
            return
        }
//        if #available(iOS 11, *) {
//            maskedCorners = corners
//            cornerRadius = radius
//        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.mask = mask
       // }
    }
    
    @discardableResult
    public func wrapCornerRadiusMin(radius:CGFloat)->CGFloat{
        if cornerRadius > bounds.size.min.halved{
            cornerRadius = bounds.size.min.halved
            return bounds.size.min.halved
        }
        return radius
    }
    
    
}
