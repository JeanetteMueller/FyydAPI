//
//  FyydEpisode.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 11.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

class FyydEpisode {
    private let data:[String:Any]
    
    var title       : String?{
        get{
            if let title = data["title"]{
                return title as? String
            }
            return nil
        }
    }
    
    var fyydUrl     : String{
        get{
            if let url = data["fyydURL"] as? String{
                return url
            }else if let url = data["url_fyyd"] as? String{
                return url
            }else {
                return String.init(format: "https://fyyd.de/episode/%d", data["id"] as! Int32)
            }
        }
    }
    var fyydId      : Int32{      get{ return data["id"] as! Int32 } }
    
    init(_ data:[String:Any]){
        self.data = data
        
        
    }
}
