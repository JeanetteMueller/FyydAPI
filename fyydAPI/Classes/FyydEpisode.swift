//
//  FyydEpisode.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 11.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

public class FyydEpisode {
    private let data:[String:Any]
    
    public var title       : String{
        get{
            if let title = data["title"] as? String{
                return title
            }
            return ""
        }
    }
    
    public var fyydUrl     : String?{
        get{
            if let url = data["fyydURL"] as? String, !url.isEqual(""){
                return url
            }else if let url = data["url_fyyd"] as? String, !url.isEqual(""){
                return url
            }else if self.fyydId > 0{
                return String(format: "https://fyyd.de/episode/%d", self.fyydId)
            }
            return nil
        }
    }
    public var fyydId      : Int32{
        get{
            if let id = data["id"] as? Int32{
                return id
            }
            return -1
        }
    }
    
    public init(_ data:[String:Any]){
        self.data = data
        
        
    }
}
