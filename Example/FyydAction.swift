//
//  FyydAction.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 11.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

class FyydAction {
    private let data:[String:Any]
    
    var message: String{
        get{
            if let message = self.data["data"] as? String{
                return message
            }
            return "no informations"
        }
    }
    
    init(_ data:[String:Any]){
        self.data = data
        
        
    }
}
