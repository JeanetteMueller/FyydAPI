//
//  FyydRequest.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 05.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

enum FyydRequestStatus {
    case new, loading, failed, done
}

class FyydRequest {
    
    var state: FyydRequestStatus = .new
    
    var podcasts: [FyydPodcast]?
    var episodes: [FyydEpisode]?
    var collections: [FyydCollection]?
    var curations: [FyydCuration]?
    
    var meta: [String:Any]?
    
    var sessionManager: SessionManager
    
    init(){
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
}
