//
//  FyydAPI.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 05.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire
import SafariServices


class FyydAPI {
    
    static let shared: FyydAPI = {
        
        let instance = FyydAPI()
        
        return instance
    }()
    
    var clientID:String?{
        get{
            return self.getFyydCliendId()
        }
    }
    var token:String?{
        get{
            return self.getFyydToken()
        }
    }
    
    var isLoggedIn: Bool{
        get{
            if self.getFyydCliendId() != nil && self.getFyydToken() != nil{
                return true
            }
            return false
        }
    }
    
    var authHandler: FyydAPILoginHandler?
    
    func authenticate(_ clientId:String, handler: @escaping FyydAPILoginHandler) {
        
        //https://fyyd.de/oauth/authorize?client_id=###
        
        self.setFyydCliendId(clientId)
        
        self.authHandler = handler
        
        var urlComponents = URLComponents.init(string: "https://fyyd.de")!
        
        urlComponents.path = "/oauth/authorize"
        
        var query = [URLQueryItem]()
        
        query.append(URLQueryItem.init(name: "client_id", value: clientId))
        
        urlComponents.queryItems = query
        
        guard let url = urlComponents.url else {
            return
        }
        
        let svc = SFSafariViewController.init(url: url)
        
        if let appDelegate = UIApplication.shared.delegate{
            
            if let root = appDelegate.window??.rootViewController{
                
                root.present(svc, animated: true, completion: {
                    print("interner safari ist offen")
                })
            }
        }
    }
    
    func logout(){
        self.setFyydCliendId(nil)
        self.setFyydToken(nil)
    }
    
    func handleOpen(_ url:URL) -> Bool{
        
        if let fragment = url.fragment{
            if fragment.substring(to: 5) == "token"{
                
                let fragmentParts = fragment.components(separatedBy: "=")
                if fragmentParts.count == 2{
                    if let token = fragmentParts.last{
                        self.setFyydToken(token)
                        
                        if let handler = self.authHandler{
                            handler(nil)
                        }
                        
                        let appDelegate = UIApplication.shared.delegate
                        
                        if let root = appDelegate?.window??.rootViewController{
                            
                            root.dismiss(animated: true, completion: nil)
                        }
                        
                        return true
                    }
                }
            }
        }
        if let handler = self.authHandler{
            
            handler(FyydAPIError.Auth.failed)
        }
        return false
    }
    
    private func getFyydCliendId() -> String?{
        let defaults = UserDefaults.standard
        
        if let result = defaults.value(forKey: kfyydAuthClientId) {
            if result is String{
                return result as? String
            }
        }
        
        return nil
    }
    
    private func setFyydCliendId(_ key:String?){
        print("setFyydCliendId", key as Any)
        let defaults = UserDefaults.standard
        if let k = key{
            defaults.set(k, forKey:kfyydAuthClientId)
        }else{
            defaults.removeObject(forKey:kfyydAuthClientId)
        }
        defaults.synchronize()
    }
    
    private func getFyydToken() -> String?{
        let defaults = UserDefaults.standard
        
        if let result = defaults.value(forKey: kfyydAuthToken) {
            if result is String{
                return result as? String
            }
        }
        
        return nil
    }
    
    private func setFyydToken(_ key:String?){
        print("setFyydToken", key as Any)
        let defaults = UserDefaults.standard
        if let k = key{
            defaults.set(k, forKey:kfyydAuthToken)
        }else{
            defaults.removeObject(forKey:kfyydAuthToken)
        }
        defaults.synchronize()
    }
}

