//
//  FyydAPI.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 05.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

public class FyydAPI {
    
    public static let shared: FyydAPI = {
        
        let instance = FyydAPI()
        
        return instance
    }()
    
    public var clientID:String?{
        get{
            return FyydAPI.getFyydCliendId()
        }
    }
    public var token:String?{
        get{
            return FyydAPI.getFyydToken()
        }
    }
    
    public var isLoggedIn: Bool{
        get{
            if FyydAPI.getFyydCliendId() != nil && FyydAPI.getFyydToken() != nil{
                return true
            }
            return false
        }
    }
    
    public var authHandler: FyydAPILoginHandler?
    
    
    // MARK: Helper
    
    public class func getFyydCliendId() -> String?{
        let defaults = UserDefaults.standard
        
        if let result = defaults.value(forKey: kfyydAuthClientId) {
            if result is String{
                return result as? String
            }
        }
        
        return nil
    }
    
    public func setFyydCliendId(_ key:String?){
        log("setFyydCliendId", key as Any)
        let defaults = UserDefaults.standard
        if let k = key{
            defaults.set(k, forKey:kfyydAuthClientId)
        }else{
            defaults.removeObject(forKey:kfyydAuthClientId)
        }
        defaults.synchronize()
    }
    
    public class func getFyydToken() -> String?{
        let defaults = UserDefaults.standard
        
        if let result = defaults.value(forKey: kfyydAuthToken) {
            if result is String{
                return result as? String
            }
        }
        
        return nil
    }
    
    public func setFyydToken(_ key:String?){
        log("setFyydToken", key as Any)
        let defaults = UserDefaults.standard
        if let k = key{
            defaults.set(k, forKey:kfyydAuthToken)
        }else{
            defaults.removeObject(forKey:kfyydAuthToken)
        }
        defaults.synchronize()
    }
    
    public class func getFyydUserID() -> Int?{
        let defaults = UserDefaults.standard
        
        if let result = defaults.value(forKey: kfyydUserID) {
            if result is Int{
                return result as? Int
            }
        }
        
        return nil
    }
    
    public func setFyydUserID(_ key:Int?){
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

