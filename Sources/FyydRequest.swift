//
//  FyydRequest.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 05.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

enum FyydRequestStatus {
    case new, loading, failed, done
}

class FyydRequest {
    
    var state: FyydRequestStatus = .new
    var podcasts: [FyydPodcast]?
    
    
    func loadPodcast(by identifier:Int, callback: @escaping (FyydPodcast) -> Void) {
        // https://api.fyyd.de/podcast/show?id=85
    }
    func loadPodcasts(_ count:Int, offset start:Int = 0, _ searchTerm:String? = nil, callback: @escaping ([FyydPodcast]?, Int) -> Void){
        
        //https://api.fyyd.de/podcasts/show?count=3
        
        //https://api.fyyd.de/search/iphone/2
        
        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents.init(string: "https://api.fyyd.de")!


        if let search = searchTerm{
            urlComponents.path = String.init(format: "/search/%@/%d", search.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, count);

        }else{
            urlComponents.path = "/podcasts/show"
            
            
            var query = [URLQueryItem]()
            
            query.append(URLQueryItem.init(name: "count", value: String.init(format: "%d", count)))
            if start > 0{

                query.append(URLQueryItem.init(name: "from", value: String.init(format: "%d", start)))
            }
            urlComponents.queryItems = query
            
            

            
        }
        
        guard let url = urlComponents.url else {
            return
        }
        self.state = .loading
        
        let aRequest = Alamofire.request(url)
        
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
                    self.state = .done
                    callback(self.podcasts, start)
                    
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
            callback(nil, start)
        })
        
    }
    
}
