//
//  FyydRequest+Episode.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 11.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

public extension FyydRequest{
    
    func search(_ parameters:Parameters, callback: @escaping ([FyydEpisode]?) -> Void){
        
        //podcasts nach sucheingabe
        //https://api.fyyd.de/sucheingabe/iphone/99

        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents(string: kfyydUrlApi)!

        
        urlComponents.path = "/episode/search"
        
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

    
        let aRequest = FyydManager.shared.sessionManager.request(url, method: .post, parameters: parameters, headers: headers)

        aRequest.validate().responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any]{
                    
                    var e = [FyydEpisode]()
                    
                    if let items = data["data"] as? [Any]{
                        for item in items{
                            if let i = item as? [String:Any]{
                                if parameters["title"] as? String == i["title"] as? String{
                                    e.append(FyydEpisode(i))
                                }
                            }
                        }
                    }else if let items = data["data"] as? [String:Any]{
                        for item in Array(items.values){
                            if let i = item as? [String:Any]{
                                if parameters["title"] as? String == i["title"] as? String{
                                    e.append(FyydEpisode(i))
                                }
                            }
                        }
                    }
                    if e.count > 0{
                        self.episodes = e
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
            callback(self.episodes)
        })
        
    }
    
    func addEpisode(_ episode_id:Int32, toCuration curation_id:Int32, callback: @escaping (FyydAction?) -> Void){
        
        let parameters: Parameters = ["episode_id": episode_id, "curation_id": curation_id]

        var headers: HTTPHeaders?
        if let token = FyydAPI.getFyydToken(){
            headers = [
                "Authorization": "Bearer \(token)"
            ]
        }
        
        var urlComponents = URLComponents(string: kfyydUrlApi)!

        urlComponents.path = "/curate"
        
        guard let url = urlComponents.url else {
            return
        }
        
        let aRequest = FyydManager.shared.sessionManager.request(url, method: .post, parameters: parameters, headers: headers)
        aRequest.validate().responseJSON(completionHandler: { (response) in
            
            var result:FyydAction?
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any]{
                    
                    self.state = .done
                    result = FyydAction(data)
                }
                
            case .failure(let error):
                self.state = .failed
                
                if let httpResponse = response.response {
                    
                    switch httpResponse.statusCode{
                    case 401:
                        log("passwort benötigt")
                        result = FyydAction(["data":"passwort benötigt"])
                        break
                    default:
                        log("anderer Fehler", error as Any)
                        result = FyydAction(["data":"anderer Fehler"])
                        break
                    }
                }else{
                    log("anderer Fehler ohne response", error as Any)
                    result = FyydAction(["data":"anderer Fehler ohne response"])
                }
                
            }
            callback(result)
        })
    }
}
