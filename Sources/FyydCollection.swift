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
                return value
            }
            return nil
        }
    }
    var thumbImageURL: String?{
        get{
            
            if let value = data["thumbImageURL"] as? String{
                return value
            }
            return nil
        }
    }
    var microImageURL: String?{
        get{
            
            if let value = data["microImageURL"] as? String{
                return value
            }
            return nil
        }
    }
    var url: String{
        get{
            
            if let url = data["url"] as? String{
                return url
            }
            return ""
        }
    }
    
    var podcasts: [FyydPodcast]?{
        get{
            
            if let podcasts = data["podcasts"] as? [String:Any]{
                var result = [FyydPodcast]()
                
                
                for item in Array(podcasts.values){
                    result.append(FyydPodcast.init(item as! [String:Any]))
                }
                
                return result
            }
            return nil
        }
    }
    
    init(_ data:[String:Any]){
        self.data = data
        
        
    }
}
