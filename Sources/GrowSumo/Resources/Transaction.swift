//
//  Transaction.swift
//  GrowSumo
//
//  Created by Kyle Ishie on 8/26/18.
//

import Foundation
import RESTClient

/*
 {
     "key": "tran_a80cb515fe",
     "customer_key": "cus_A2ns20a2L93",
     "partner_key": "bertramgilfoyle",
     "amount":3000,
     "currency": "USD",
     "created_at":1472503412153,
     "updated_at":1472503412153,
     "test": false,
 }
*/
public struct Transaction : Codable {
    
    public let key: String
    public let customerKey: String
    public let partnerKey: String
    public let amount: Int
    public let currency: String
    public let createdAt: Date
    public let updatedAt: Date
    public let test: Bool
    
    
    public enum CodingKeys : String, CodingKey {
        case key
        case customerKey = "customer_key"
        case partnerKey = "partner_key"
        case amount
        case currency
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case test
    }
    
}

extension Transaction : Model {}
extension Transaction : Resource {}
extension Transaction : Identifiable {}
extension Transaction : Creatable {}
extension Transaction : Deleteable {}


//MARK:  Creation
public struct TransactionCreationContext : Encodable {
    
    public let key: String
    public let amount: Int
    public let currency: String
    public let productKey: String
    
    public enum CodingKeys : String, CodingKey {
        case key
        case amount
        case currency
        case productKey = "product_key"
    }
    
}

extension TransactionCreationContext : _CreationContext {
    
    public typealias Root = Transaction
    
}
extension TransactionCreationContext : Creatable {}
extension TransactionCreationContext : Resource {}
