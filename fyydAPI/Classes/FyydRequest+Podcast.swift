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
        
        var urlComponents = URLComponents(string: kfyydUrlApi)!
        
        urlComponents.path = "/podcast/show"
        
        var query = [URLQueryItem]()
        query.append(URLQueryItem(name: "id", value: String(format: "%d", identifier)))
        urlComponents.queryItems = query
        
        guard let url = urlComponents.url else {
            return
        }
        self.state = .loading
        
        let aRequest = FyydManager.shared.sessionManager.request(url)
        
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
                        callback(FyydPodcast(item))
                    }
                    
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
            callback(nil)
        })
        
    }
    func loadPodcasts(_ count:Int, offset start:Int = 0, searchTerm:String? = nil, categorie:FyydCategory? = nil, recommendId:Int32? = nil, recommendSlug:String? = nil, apiBase: String = kfyydUrlApi, callback: @escaping ([FyydPodcast]?, Int) -> Void){
        
        //allgemein alle podcasts sortiert nach ranking
        //https://api.fyyd.de/podcasts/show?count=99
        
        //podcasts nach sucheingabe
        //https://api.fyyd.de/sucheingabe/iphone/99
        
        //podcasts einer categorie
        //https://api.fyyd.de/category?category_id=62&count=99
        
        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents(string: apiBase)!
        var query = [URLQueryItem]()
        let params = [String:Any]()
        let method: HTTPMethod = .get
        
        if let search = searchTerm{
            
            urlComponents.path = String(format: "/search/%@/%d", search.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, count);

        }else if let cat = categorie{
            
            urlComponents.path = "/category"
            
            query.append(URLQueryItem(name: "category_id", value: String(format: "%d", cat.identifier)))
            
        }else if let rID = recommendId{
          
            urlComponents.path = urlComponents.path + "/podcast/recommend"
            
            query.append(URLQueryItem(name: "podcast_id", value: String(format: "%d", rID)))
            
        }else if let rSlug = recommendSlug{
            
            urlComponents.path = urlComponents.path + "/podcast/recommend"
            
            query.append(URLQueryItem(name: "podcast_slug", value: rSlug))
            
        }else{
            
            urlComponents.path = "/podcasts/show"
        }
        
        query.append(URLQueryItem(name: "count", value: String(format: "%d", count)))
        if start > 0{
            query.append(URLQueryItem(name: "from", value: String(format: "%d", start)))
        }
        
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
        
        log("url: ", url.absoluteString)
        
        let aRequest = FyydManager.shared.sessionManager.request(url, method: method, parameters: params, headers: headers)
        
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
                    
                    if let items = data["data"] as? [Any]{
                        for item in items{
                            if let i = item as? [String:Any]{
                                p.append(FyydPodcast(i))
                            }
                        }
                    }else if let items = data["data"] as? [String:Any]{
                        for item in Array(items.values){
                            if let i = item as? [String:Any]{
                                p.append(FyydPodcast(i))
                            }
                        }
                    }else if let items = data["data"] as? [[String:Any]]{
                        for item in items{
                            p.append(FyydPodcast(item))
                            
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
            callback(self.podcasts, start)
        })
        
    }
}
