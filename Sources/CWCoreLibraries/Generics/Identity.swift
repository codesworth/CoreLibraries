//
//  File.swift
//  
//
//  Created by Shadrach Mensah on 06/02/2020.
//

import Foundation

public protocol Identity {
    static var Identifier:String {get}
}


extension Identity{
    public static var Identifier:String{
        return "\(Self.self)"
    }
}
