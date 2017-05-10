//
//  FyydDefinitions.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 06.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

let kfyydAuthClientId   :String = "fyydAuthClientId"
let kfyydAuthToken      :String = "kfyydAuthToken"
let kfyydUserID         :String = "kfyydUserID"

let kfyydUrlBase        :String = "https://fyyd.de"
let kfyydUrlApi         :String = "https://api.fyyd.de"

public enum FyydAPIError {}

public extension FyydAPIError{
    public enum Auth {
        case failed, succeed, canceled
        
        var localizedDescription:String{
            get{
                return "localizedDescription"
            }
        }
    }
    
    
}

public typealias FyydAPILoginHandler = (FyydAPIError.Auth?) -> Swift.Void


let FyydCategories = [
    FyydCategory(identifier: 1, andSlug:"arts", andName:"network_category_1301".localized, andImage:"kunst"),
    FyydCategory(identifier: 8, andSlug:"business", andName:"network_category_1321".localized, andImage:"wirtschaft"),
    FyydCategory(identifier: 14, andSlug:"comedy", andName:"network_category_1303".localized, andImage:"comedy"),
    FyydCategory(identifier: 15, andSlug:"education", andName:"network_category_1304".localized, andImage:"bildung"),
    FyydCategory(identifier: 21, andSlug:"games-hobbies", andName:"network_category_1323".localized, andImage:"spiele"),
    FyydCategory(identifier: 27, andSlug:"government-organizations", andName:"network_category_1325".localized, andImage:"regierung"),
    FyydCategory(identifier: 32, andSlug:"health", andName:"network_category_1307".localized, andImage:"gesundheit"),
    FyydCategory(identifier: 37, andSlug:"kids-family", andName:"network_category_1305".localized, andImage:"familie"),
    FyydCategory(identifier: 38, andSlug:"music", andName:"network_category_1310".localized, andImage:"musik"),
    FyydCategory(identifier: 39, andSlug:"news-politics", andName:"network_category_1311".localized, andImage:"news"),
    FyydCategory(identifier: 40, andSlug:"religion-spirituality", andName:"network_category_1314".localized, andImage:"religion"),
    FyydCategory(identifier: 48, andSlug:"science-medicine", andName:"network_category_1315".localized, andImage:"wissenschaft"),
    FyydCategory(identifier: 52, andSlug:"society-culture", andName:"network_category_1324".localized, andImage:"gesellschaft"),
    FyydCategory(identifier: 57, andSlug:"sports-recreation", andName:"network_category_1316".localized, andImage:"freizeit"),
    FyydCategory(identifier: 62, andSlug:"technology", andName:"network_category_1318".localized, andImage:"technologie"),
    FyydCategory(identifier: 67, andSlug:"tv-film", andName:"network_category_1309".localized, andImage:"tv_film")
]


