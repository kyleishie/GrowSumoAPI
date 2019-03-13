//
//  Customer.swift
//  365Integrations-Server
//
//  Created by Kyle Ishie on 8/25/18.
//

import Foundation
import RESTClient

/*
 {
     "key": "cus_a80SV515feLAA",
     "provider_key": "cus_A2VAIipQOkS7nV",
     "name": "John Smith",
     "email": "johnsmith@gmail.com",
     "partner_key": "bertramgilfoyle",
     "test": false,
     "created_at":1472503412153,
     "updated_at":1472503412153
 }
*/
public struct Customer : Codable {

    public let key: String
    public let providerKey: String
    public let name: String
    public let email: String
    public let partnerKey: String
    public let test: Bool
    public let createdAt: Date
    public let updatedAt: Date
    
    public enum CodingKeys: String, CodingKey {
        case key
        case providerKey = "provider_key"
        case name
        case email
        case partnerKey = "partner_key"
        case test
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    public static func create(key: String, partnerKey: String, email: String, name: String, completion: @escaping (Customer?, Swift.Error?) -> Void) throws {
        let cc = CustomerCreationContext(key: key, partnerKey: partnerKey, email: email, name: name)
        try GrowSumo.default.create(cc, responseType: Response<Customer>.self, completionHandler: { result in
            switch result {
            case let .success(response):
                completion(response.rdata, nil)
            case let .failure(_, error):
                completion(nil, error)
            case let .systemFailure(error):
                completion(nil, error)

            }
        }).resume()
    }
    
    func archive() throws {
        
    }
    
}


extension Customer : Model {}
extension Customer : Resource {}
extension Customer : Identifiable {}
extension Customer : Creatable {}
extension Customer : Deleteable {}


//MARK: Creation
public struct CustomerCreationContext : Encodable {
    
    public let key: String
    public let partnerKey: String
    public let email: String
    public let name: String
    
    public enum CodingKeys: String, CodingKey {
        case key
        case name
        case email
        case partnerKey = "partner_key"
    }
    
}

extension CustomerCreationContext : _CreationContext {
    
    public typealias Root = Customer
    
}
extension CustomerCreationContext : Creatable {}
extension CustomerCreationContext : Resource {}
