//
//  Model.swift
//  GrowSumo
//
//  Created by Kyle Ishie on 8/26/18.
//

import Foundation
import RESTClient

public protocol Model {
    
    var key: String { get }
    
}

extension Model where Self : Identifiable {
    
    public var id: String {
        return key
    }
    
}
