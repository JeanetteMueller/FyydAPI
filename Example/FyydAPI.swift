//
//  FyydAPI.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 05.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation



class FyydAPI {
    
    static let shared: FyydAPI = {
        
        let instance = FyydAPI()
        
        return instance
    }()
    
    var clientID:String?{
        get{
            return FyydAPI.getFyydCliendId()
        }
    }
    var token:String?{
        get{
            return FyydAPI.getFyydToken()
        }
    }
    
    var isLoggedIn: Bool{
        get{
            if FyydAPI.getFyydCliendId() != nil && FyydAPI.getFyydToken() != nil{
                return true
            }
            return false
        }
    }
    
    var authHandler: FyydAPILoginHandler?
    
    
    // MARK: Helper
    
    class func getFyydCliendId() -> String?{
        let defaults = UserDefaults.standard
        
        if let result = defaults.value(forKey: kfyydAuthClientId) {
            if result is String{
                return result as? String
            }
        }
        
        return nil
    }
    
    func setFyydCliendId(_ key:String?){
        log("setFyydCliendId", key as Any)
        let defaults = UserDefaults.standard
        if let k = key{
            defaults.set(k, forKey:kfyydAuthClientId)
        }else{
            defaults.removeObject(forKey:kfyydAuthClientId)
        }
        defaults.synchronize()
    }
    
    class func getFyydToken() -> String?{
        let defaults = UserDefaults.standard
        
        if let result = defaults.value(forKey: kfyydAuthToken) {
            if result is String{
                return result as? String
            }
        }
        
        return nil
    }
    
    func setFyydToken(_ key:String?){
        log("setFyydToken", key as Any)
        let defaults = UserDefaults.standard
        if let k = key{
            defaults.set(k, forKey:kfyydAuthToken)
        }else{
            defaults.removeObject(forKey:kfyydAuthToken)
        }
        defaults.synchronize()
    }
    
    class func getFyydUserID() -> Int?{
        let defaults = UserDefaults.standard
        
        if let result = defaults.value(forKey: kfyydUserID) {
            if result is Int{
                return result as? Int
            }
        }
        
        return nil
    }
    
    func setFyydUserID(_ key:Int?){
        log("setFyydUserID", key as Any)
        let defaults = UserDefaults.standard
        if let k = key{
            defaults.set(k, forKey:kfyydUserID)
        }else{
            defaults.removeObject(forKey:kfyydUserID)
        }
        defaults.synchronize()
    }
    
}

