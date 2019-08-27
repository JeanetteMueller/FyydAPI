//
//  FyydCollection.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 10.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

class FyydCollection{
    private let data:[String:Any]
    
    var fyydId:Int32{
        get{
            
            if let value = data["id"] as? Int32{
                return value
            }
            return -1
        }
    }
    var title:String?{
        get{
            
            if let value = data["title"] as? String{
                return value
            }
            return nil
        }
    }
    var desciption:String?{
        get{
            
            if let value = data["desciption"] as? String{
                return value 
            }
            return nil
        }
    }
    var layoutImageURL: String?{
        get{
            
            if let value = data["layoutImageURL"] as? String{
                
                return kfyydUrlBase.appending(value)
            }
            return nil
        }
    }
    var thumbImageURL: String?{
        get{
            
            if let value = data["thumbImageURL"] as? String{
                return kfyydUrlBase.appending(value)
            }
            return nil
        }
    }
    var microImageURL: String?{
        get{
            
            if let value = data["microImageURL"] as? String{
                return kfyydUrlBase.appending(value)
            }
            return nil
        }
    }
    var fyydUrl: String{
        get{
            
            if let url = data["url"] as? String{
                return url
            }
            return ""
        }
    }
    
    var podcasts: [FyydPodcast]?{
        get{
            var result = [FyydPodcast]()
            if let podcasts = data["podcasts"] as? [Any]{
                for item in podcasts{
                    if let i = item as? [String:Any]{
                        result.append(FyydPodcast(i))
                    }
                }
            }else if let items = data["podcasts"] as? [String:Any]{
                for item in Array(items.values){
                    if let i = item as? [String:Any]{
                        result.append(FyydPodcast(i))
                    }
                }
            }
            if result.count > 0{
                return result
            }
            return nil
        }
    }
    
    init(_ data:[String:Any]){
        self.data = data
        
        
    }
}
