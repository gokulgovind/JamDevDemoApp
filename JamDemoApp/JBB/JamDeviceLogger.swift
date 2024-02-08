//
//  JamDeviceLogger.swift
//  JamDemoApp
//
//  Created by Gokul on 01/02/24.
//

import Foundation
import UIKit


/// Value type instance that holds all information about sharable contents of the bug.
internal struct JamDeviceLogger: JamLoggerProtocol {
    
    var deviceModel: String?
    
    var deviceOS: String?
    
    var deviceOrientation: Int?
    
    var batteryPercent: Int?
    
    var batteryState: Int?
    
    var appVersion: String?
    
    var appScreenShot: UIImage?
    
    /// Key value pair of sharable info, used to construct a JSON that could be shared along with app screen shot.
    lazy var shareContent: [String: Any] = {
        return ["deviceModel": deviceModel ?? "",
                "deviceOS": deviceOS ?? "",
                "deviceOrientation": deviceOrientation ?? 0,
                "batteryPercent": batteryPercent ?? 0,
                "appVersion": appVersion ?? ""]
    }()
    
    /// Gather all environmental properties for the bug.
    mutating func getDeviceInfo() {
        deviceInfo()
        batteryInfo()
        appInfo()
        getAppScreenShot()
    }
    
    
    /// Get battery related informations.
    /// - batteryPercent
    /// - batteryState
    private mutating func batteryInfo() {
        
        defer {
            UIDevice.current.isBatteryMonitoringEnabled = false
        }
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        batteryPercent = Int(UIDevice.current.batteryLevel * Float(100))
        batteryState = UIDevice.current.batteryState.rawValue
    }
    
    /// Get device specific information,
    /// - deviceOS
    /// - deviceModel
    /// - deviceOrientation
    private mutating func deviceInfo() {
        deviceOS = UIDevice.current.systemVersion
        deviceModel = UIDevice.modelName
        deviceOrientation = UIDevice.current.orientation.rawValue
    }
    
    /// Collects application specific informations.
    private mutating func appInfo() {
        appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// Creates snap of current rendering app UI.
    mutating func getAppScreenShot() {
        let snap = UIApplication.shared.keyWindow!.snapshotView(afterScreenUpdates: true)
        if let image = snap?.takeScreenshot() {
            appScreenShot = image
        }
    }
}
