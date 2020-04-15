//
//  UIImage+Extension.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 23/11/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit



extension UIImage {
    public func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func fixImageOrientation()->UIImage?{
        if imageOrientation == .up {return self}
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func dataFromJPEG()-> Data?{
        var compression:CGFloat = 1
        if let data = jpegData(compressionQuality: compression){
            if data.count < ImageSizes.min.rawValue{
                compression = 0.6
                return jpegData(compressionQuality: compression)
            }
            if data.count < ImageSizes.minlg.rawValue{
                compression = 0.5
                return jpegData(compressionQuality: compression)
            }
            if data.count < ImageSizes.medium.rawValue{
                compression = 0.4
                return jpegData(compressionQuality: compression)
            }
            if data.count < ImageSizes.max.rawValue{
                compression = 0.2
                return jpegData(compressionQuality: compression)
            }
            
            compression = 0.1
            return jpegData(compressionQuality: compression)
            
        }
        return nil
    }
    
    enum ImageSizes:Int{
        case supermax = 32000000
        case max = 16000000
        case medium = 8000000
        case minlg = 4000000
        case min = 1000000
    }
}
