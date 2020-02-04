//
//  UIScreen+Extensions.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 10/04/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit

extension UIScreen{
    
    
    public static var orientation:Orientation{
        let size = main.bounds
        if size.width > size.height{
            return .landscape
        }
        return .potrait
    }
    public enum SizeNative:Int{
        case iPad_norm = 3145728
        case pro_10_5 = 3709632
        case pro_11 = 3983184
        case pro_12_9 = 5595136
    }

    
    public enum Handle{
        
        case pad_norm
        case pad_pro_9_7
        case pad_pro_10_5
        case pad_pro_11
        case pad_pro_maxx
        case xmax_xr
        case xs_x
        case pluses
        case eight_lower
        case fives
        case lowly
        
        case ipad
    }
    
    public enum Orientation{
        case potrait
        case landscape
    }
    
    public static func hasNotch()->Bool{
        
        let handle = main.screenType()
        switch handle {
        case .pluses,.eight_lower,.fives,.lowly:
            return false
        case .xs_x, .xmax_xr:
            return true
        default:
            return false
        }
    }
    
    public func screenType()->Handle{
        let height = UIScreen.main.bounds.height
        let interface = UIDevice.current.userInterfaceIdiom
        
        switch interface {
        case .phone:
            return handleFor(height: height)
        case .pad:
            return iPadHandleFor(native: UIScreen.main.nativeBounds.size)
        default:
            return handleFor(height: height)
        }
        
        
    }
    
    public func iPadHandleFor(native size:CGSize)->Handle{
        if size.product >= SizeNative.pro_12_9.rawValue{
            return .pad_pro_maxx
        }
        if size.product >= SizeNative.pro_11.rawValue{
            return .pad_pro_11
        }
        if size.product >= SizeNative.pro_10_5.rawValue{
            return .pad_pro_10_5
        }
        if size.product >= SizeNative.iPad_norm.rawValue{
            return .pad_pro_9_7
        }
        return .pad_norm

    }
    
    public func handleFor(height:CGFloat)->Handle{
    
        
        if height > 890{
            return .xmax_xr
        }
        if height > 800 {
            return .xs_x
        }
        
        if height > 700 {
            return .pluses
        }
        
        if height > 650 {
            return .eight_lower
        }
        
        if height > 550 {
            return .fives
        }
        
        return .lowly
    }
}
