//
//  FyydRequest+Collection.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 10.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

extension FyydRequest {
    
    func loadMyCollections(callback: @escaping ([FyydCollection]?) -> Void) {
        
        return loadCollections(userID: FyydAPI.getFyydUserID(), callback: callback)
        
        /*
        //https://api.fyyd.de/account/collections
        
        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents.init(string: kfyydUrlApi)!
        urlComponents.path = "/account/collections"
        
        var query = [URLQueryItem]()
        query.append(URLQueryItem.init(name: "getcontent", value: "1"))
        urlComponents.queryItems = query

        guard let url = urlComponents.url else {
            return
        }
        self.state = .loading
        
        var headers: HTTPHeaders?
        if let token = FyydAPI.getFyydToken(){
            headers = [
                "Authorization": "Bearer \(token)"
            ]
        }
        let aRequest = self.sessionManager.request(url, parameters: [:], headers: headers)
        
        aRequest.validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any]{
                    
                    var c = [FyydCollection]()
                    
                    if let items = data["data"] as? [Any]{
                        for item in Array(items.values){
                            c.append(FyydCollection.init(item as! [String:Any]))
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
                        print("passwort benötigt")
                        
                        break
                    default:
                        print("anderer Fehler", error as Any)
                        break
                    }
                }else{
                    print("anderer Fehler ohne response", error as Any)
                }
            }
            callback(self.collections)
        })
 */
    }
    func loadCollections(userID id:Int? = nil, callback: @escaping ([FyydCollection]?) -> Void) {
        //https://api.fyyd.de/user/collections?id=1548
        
        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents.init(string: kfyydUrlApi)!
        urlComponents.path = "/user/collections"
        
        var query = [URLQueryItem]()
        if let userID = id{
            query.append(URLQueryItem.init(name: "id", value: String.init(format: "%d", userID)))
        }

        query.append(URLQueryItem.init(name: "getcontent", value: "1"))

        
        urlComponents.queryItems = query
        
        guard let url = urlComponents.url else {
            return
        }
        self.state = .loading
        
        let aRequest = self.sessionManager.request(url)
        
        aRequest.validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any]{
                    
                    var c = [FyydCollection]()
                    
                    if let items = data["data"] as? [Any]{
                        for item in items{
                            c.append(FyydCollection.init(item as! [String:Any]))
                        }
                    }else if let items = data["data"] as? [String:Any]{
                        for item in Array(items.values){
                            c.append(FyydCollection.init(item as! [String:Any]))
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
                        print("passwort benötigt")
                        
                        break
                    default:
                        print("anderer Fehler", error as Any)
                        break
                    }
                }else{
                    print("anderer Fehler ohne response", error as Any)
                }
            }
            callback(self.collections)
        })
    }
}
