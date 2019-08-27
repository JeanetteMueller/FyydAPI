//
//  FyydRequest.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 05.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

public enum FyydRequestStatus {
    case new, loading, failed, done
}

public class FyydRequest {
    
    public var state: FyydRequestStatus = .new
    
    public var podcasts: [FyydPodcast]?
    public var episodes: [FyydEpisode]?
    public var collections: [FyydCollection]?
    public var curations: [FyydCuration]?
    
    public var meta: [String:Any]?
    
    public init(){
        
    }
}
