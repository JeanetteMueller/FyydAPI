//
//  FyydRequest+Podcast.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 10.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

extension FyydRequest {
    
    func loadPodcast(by identifier:Int, callback: @escaping (FyydPodcast?) -> Void) {
        // https://api.fyyd.de/podcast/show?id=85
        
        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents.init(string: kfyydUrlApi)!
        
        urlComponents.path = "/podcast/show"
        
        var query = [URLQueryItem]()
        query.append(URLQueryItem.init(name: "id", value: String.init(format: "%d", identifier)))
        urlComponents.queryItems = query
        
        guard let url = urlComponents.url else {
            return
        }
        self.state = .loading
        
        let aRequest = self.sessionManager.request(url)
        
        //        if let user = feedRecord.username, let pass = feedRecord.password{
        //            if !user.isEqual("") && !pass.isEqual(""){
        //
        //                aRequest.authenticate(user: user, password: pass)
        //            }
        //        }
        aRequest.validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any]{
                    
                    
                    
                    if let item = data["data"] as? [String:Any]{
                        
                        self.state = .done
                        callback(FyydPodcast.init(item))
                    }
                    
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
            callback(nil)
        })
        
    }
    func loadPodcasts(_ count:Int, offset start:Int = 0, searchTerm:String? = nil, categorie:FyydCategory? = nil, callback: @escaping ([FyydPodcast]?, Int) -> Void){
        
        //allgemein alle podcasts sortiert nach ranking
        //https://api.fyyd.de/podcasts/show?count=99
        
        //podcasts nach sucheingabe
        //https://api.fyyd.de/sucheingabe/iphone/99
        
        //podcasts einer categorie
        //https://api.fyyd.de/category?category_id=62&count=99
        
        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents.init(string: kfyydUrlApi)!
        var query = [URLQueryItem]()
        
        if let search = searchTerm{
            urlComponents.path = String.init(format: "/search/%@/%d", search.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, count);
            
        }else if let cat = categorie{
            urlComponents.path = "/category"
            
            query.append(URLQueryItem.init(name: "category_id", value: String.init(format: "%d", cat.identifier)))
        }else{
            urlComponents.path = "/podcasts/show"
        }
        
        query.append(URLQueryItem.init(name: "count", value: String.init(format: "%d", count)))
        if start > 0{
            query.append(URLQueryItem.init(name: "from", value: String.init(format: "%d", start)))
        }
        
        urlComponents.queryItems = query
        
        guard let url = urlComponents.url else {
            return
        }
        self.state = .loading
        
        let aRequest = self.sessionManager.request(url)
        
        //        if let user = feedRecord.username, let pass = feedRecord.password{
        //            if !user.isEqual("") && !pass.isEqual(""){
        //
        //                aRequest.authenticate(user: user, password: pass)
        //            }
        //        }
        aRequest.validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any]{
                    
                    var p = [FyydPodcast]()
                    
                    if let items = data["data"] as? [String:Any]{
                        for item in Array(items.values){
                            p.append(FyydPodcast.init(item as! [String:Any]))
                        }
                    }
                    if p.count > 0{
                        self.podcasts = p
                    }
                    
                    if let m = data["meta"] as? [String:Any]{
                        self.meta = m
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
            callback(self.podcasts, start)
        })
        
    }
}
