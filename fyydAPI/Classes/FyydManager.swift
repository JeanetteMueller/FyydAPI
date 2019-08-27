//
//  FyydManager.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 10.04.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation
import Alamofire

public let kFyydCollectionGuidPrefix = "fyyd_collection"

public class FyydManager {

    public static let shared: FyydManager = {

        let instance = FyydManager()

        return instance
    }()

    public lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["User-Agent"] = UserAgentHelper.userAgent()
        configuration.httpAdditionalHeaders = defaultHeaders

        return Alamofire.SessionManager(configuration: configuration)
    }()
    public lazy var sessionmanagerBackground: SessionManager = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "de.themaverick.podcat.FyydManager.background")
        configuration.sessionSendsLaunchEvents = true
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["User-Agent"] = UserAgentHelper.userAgent()
        configuration.httpAdditionalHeaders = defaultHeaders

        return Alamofire.SessionManager(configuration: configuration)
    }()
}
