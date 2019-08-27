//
//  FyydRequest+Collection.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 10.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

public extension FyydRequest {
    
    func loadMyCollections(callback: @escaping ([FyydCollection]?) -> Void) {
        
        return loadCollections(userID: FyydAPI.getFyydUserID(), callback: callback)
        
    }
    func loadCollections(userID id:Int? = nil, callback: @escaping ([FyydCollection]?) -> Void) {
        //https://api.fyyd.de/user/collections?id=1548
        
        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents(string: kfyydUrlApi)!
        urlComponents.path = "/user/collections"
        
        var query = [URLQueryItem]()
        if let userID = id{
            query.append(URLQueryItem(name: "id", value: String(format: "%d", userID)))
        }

        query.append(URLQueryItem(name: "getcontent", value: "1"))

        
        urlComponents.queryItems = query
        
        guard let url = urlComponents.url else {
            return
        }
        self.state = .loading
        
        let aRequest = FyydManager.shared.sessionManager.request(url)
        
        aRequest.validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any]{
                    
                    var c = [FyydCollection]()
                    
                    if let items = data["data"] as? [Any]{
                        for item in items{
                            if let i = item as? [String:Any]{
                                c.append(FyydCollection(i))
                            }
                        }
                    }else if let items = data["data"] as? [String:Any]{
                        for item in Array(items.values){
                            if let i = item as? [String:Any]{
                                c.append(FyydCollection(i))
                            }
                        }
                    }
                    if c.count > 0{
                        self.collections = c
                    }
                    
                    self.state = .done
                    
                }
                
            case .failure(let error):
                self.state = .failed
                if let httpResponse = response.response {
                    
                    switch httpResponse.statusCode{
                    case 401:
                        log("passwort benötigt")
                        
                        break
                    default:
                        log("anderer Fehler", error as Any)
                        break
                    }
                }else{
                    log("anderer Fehler ohne response", error as Any)
                }
            }
            callback(self.collections)
        })
    }
}
