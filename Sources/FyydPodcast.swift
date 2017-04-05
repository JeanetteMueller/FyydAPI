//
//  FyydPodcast.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 05.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

class FyydPodcast {
    private let data:[String:Any]
    
    var feed: String{
        get{
            
            if let feed = data["xmlURL"]{
                return feed as! String
            }else if let feed = data["xml_url"]{
                return feed as! String
            }
            return ""
        }
    }
    var title       : String{   get{ return data["title"] as! String } }
    var image       : String?{
        get{
            
            if let feed = data["imgURL"]{
                return feed as? String
            }else if let feed = data["img_url"]{
                return feed as? String
            }
            return nil
        }
    }
    var language    : String?{   get{ return data["language"] as? String } }
    var www         : String?{
        get{
            
            if let feed = data["htmlURL"]{
                return feed as? String
            }else if let feed = data["html_url"]{
                return feed as? String
            }
            return nil
        }
    }
    var copyright   : String?{   get{ return data["author"] as? String } }
    var text        : String?{   get{ return data["description"] as? String } }
    var summary     : String?{   get{ return data["subtitle"] as? String } }
    
    var fyydUrl     : String{   get{ return data["url_fyyd"] as! String } }
    var fyydId      : Int{      get{ return data["id"] as! Int } }
    var fyydSlug    : String{   get{ return data["slug"] as! String } }
    
    
    
    init(_ data:[String:Any]){
        self.data = data
        
        
    }
}
