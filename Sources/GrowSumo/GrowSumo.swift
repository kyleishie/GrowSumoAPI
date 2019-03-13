//
//  GrowSumo.swift
//  365Integrations-Server
//
//  Created by Kyle Ishie on 8/25/18.
//

import Foundation
import RESTClient

public class GrowSumo : RESTClient<GrowSumo.Error> {
    
    /*
     {
     "status": 404,
     "error": "Not Found, could not find the requested resource",
     "message": "Not Found, could not find the requested resource"
     }
     */
    public struct Error : Swift.Error, Codable {
        
        public let status : Int?
        public let error : String?
        public let message : String?
        
        
    }
    
    private let publicKey: String
    private let privateKey: String
    
    init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        
        let keysCombinedString = publicKey + ":" + privateKey
        let keysCombinedData = keysCombinedString.data(using: .utf8)
        guard let base64KeysCombined = keysCombinedData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) else {
            fatalError("Unable to create HTTP Basic Header")
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = [
            "Content-Type" : "application/json",
            "Accept" : "application/json",
            "Authorization" : "Basic " + base64KeysCombined
        ]
        
        super.init(url: URL(string: "https://api.growsumo.com/v1/")!, sessionConfig: sessionConfig)
        
        /// Setup JSON Encoder
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .secondsSince1970
        self.encoder(jsonEncoder, for: "application/json")
        
        /// Setup JSON Decoder
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        self.decoder(jsonDecoder, for: "application/json")
        
    }
    

    public static var publicKey: String? = nil
    public static var privateKey: String? = nil

    public static let `default` : GrowSumo = {
        guard let publicKey = GrowSumo.publicKey else {
            fatalError("GrowSumo.publicKey must be set in order to user GrowSumo.default singleton instance.")
        }
        
        guard let privateKey = GrowSumo.privateKey else {
            fatalError("GrowSumo.privateKey must be set in order to user GrowSumo.default singleton instance.")
        }
        
        return GrowSumo(publicKey: publicKey, privateKey: privateKey)
    }()
}
