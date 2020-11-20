//
//  HelperNetwork.swift
//  ExampleRestApi
//
//  Created by MacBook Pro on 20/11/20.
//

import Foundation
import Alamofire

public var  URL_API = "https://icenparty.pythonanywhere.com/icenPartyWeb/api/v1/"
public var  GET_STORE = "doStore"
public var  METHOD_GET: HTTPMethod = .get

class HelperNetwork{
    
    //Example get json for method GET
    func doRequest(urlString : String,
                   parameters : Parameters,
                   method : HTTPMethod,
                   completion: @escaping (AFDataResponse <Any>)->()) {
        
        let url = URL.init(string: URL_API + urlString)
        AF.request(url!, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in  completion(response)
        }
    }
    
}
