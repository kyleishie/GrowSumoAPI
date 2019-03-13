//
//  Response.swift
//  365Integrations-Server
//
//  Created by Kyle Ishie on 8/25/18.
//

import Foundation
import RESTClient
/*
 Example Response after retreiving Customer object.
 {
     "status": 200,
     "message": "Customer created",
     "rdata": {
         "key": "cus_a80SV515feLAA",
         "provider_key": "cus_A2VAIipQOkS7nV",
         "name": "John Smith",
         "email": "johnsmith@gmail.com",
         "partner_key": "bertramgilfoyle",
         "test": false,
         "created_at":1472503412153,
         "updated_at":1472503412153
     }
 }
 */

public struct Response<T : Codable> : Codable {
    
    public let status : Int
    public let message : String
    public let rdata : T
    

}

extension Response : Resource where T : Resource {
    
    public static var path : String {
        return T.path
    }
    
}
