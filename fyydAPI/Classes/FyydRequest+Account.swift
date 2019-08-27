//
//  FyydRequest+Account.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 10.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

public extension FyydRequest {
    
    func loadAccountInfo(callback: @escaping ([String:Any]?) -> Void){
        //account/info
        
        guard self.state == .new else{
            return
        }
        
        var urlComponents = URLComponents(string: kfyydUrlApi)!
        
        urlComponents.path = "/account/info"
        
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
        let aRequest = FyydManager.shared.sessionManager.request(url, parameters: [:], headers: headers)
        
        
        aRequest.validate().responseJSON(completionHandler: { (response) in
            
            var d:[String:Any]?
            
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any]{
                    
                    log(data)
                    
                    
                    self.state = .done
                    if let daten = data["data"] as? [String:Any]{
                        d = daten
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
            callback(d)
        })
    }

}
