//
//  JamLoggerProtocol.swift
//  JamDemoApp
//
//  Created by Gokul on 01/02/24.
//

import Foundation
import SwiftUI


/// Protocol Composition of Device, Battery and App protocol.
typealias JamLoggerProtocol = JBBDeviceProtocol & JBBBatteryProtocol & JBBAppProtocol


protocol JBBDeviceProtocol {
    /// Get formated model name of current device.
    /// Say `iPhone 15`, `iPhone 15Pro`.
    var deviceModel: String? {get set}
    
    var deviceOS: String? {get set}
    
    var deviceOrientation: Int? {get set}
    
    mutating func getDeviceInfo()
}

protocol JBBBatteryProtocol {
    var batteryPercent: Int? {get set}
    
    /// Battery charging state as. `Charging`, `UnPlugged`
    var batteryState: Int? {get set}
}

protocol JBBAppProtocol {
    var appVersion: String? {get set}
    
    var appScreenShot: UIImage? {get set}
    
    mutating func getAppScreenShot()
}
