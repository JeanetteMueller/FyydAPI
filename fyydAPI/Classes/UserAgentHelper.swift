//
//  UserAgentHelper.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 23.07.19.
//  Copyright © 2019 Jeanette Müller. All rights reserved.
//

import Foundation
import UIKit

class UserAgentHelper {

    class func userAgent() -> String {

        let userAgent = UAString()

        log("userAgent: \(userAgent)")

        return userAgent
    }

    //eg. Darwin/16.3.0
    class func DarwinVersion() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        let dv = String(bytes: Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
        return "Darwin/\(dv)"
    }
    //eg. CFNetwork/808.3
    class func CFNetworkVersion() -> String {
        let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary!
        let version = dictionary?["CFBundleShortVersionString"] as! String
        return "CFNetwork/\(version)"
    }

    //eg. iOS/10_1
    class func deviceVersion() -> String {
        let currentDevice = UIDevice.current
        return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
    }
    //eg. iPhone5,2
    class func deviceName() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    //eg. MyApp/1
    class func appNameAndVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let name = dictionary["CFBundleName"] as! String
        return "\(name)/\(version)"
    }

    class func UAString() -> String {
        return "\(self.appNameAndVersion()) \(self.deviceName()) \(self.deviceVersion()) \(self.CFNetworkVersion()) \(self.DarwinVersion())"
    }
}
