//
//  FyydAPI+Auth.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 12.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire
import SafariServices
import CoreData

extension FyydAPI {
    
    func authenticate(_ clientId:String, handler: @escaping FyydAPILoginHandler) {
        
        //https://fyyd.de/oauth/authorize?client_id=###
        
        self.setFyydCliendId(clientId)
        
        self.authHandler = handler
        
        var urlComponents = URLComponents.init(string: kfyydUrlBase)!
        
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
                        
                        let request = FyydRequest()
                        request.loadAccountInfo(callback: { (data) in
                            
                            if let id = data?["id"]  as? Int{
                                self.setFyydUserID(id)
                                print("got User ID")
                            }
                            
                        })
                        
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
}
