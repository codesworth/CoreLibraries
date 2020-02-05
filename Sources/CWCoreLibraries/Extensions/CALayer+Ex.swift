//
//  File.swift
//  
//
//  Created by Shadrach Mensah on 05/02/2020.
//

import Foundation


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
