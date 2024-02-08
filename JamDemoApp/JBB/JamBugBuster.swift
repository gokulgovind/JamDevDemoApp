//
//  JamBugBuster.swift
//  JamDemoApp
//
//  Created by Gokul on 01/02/24.
//

import Foundation
import UIKit


/// Possible way of invoking Jam SDK
@frozen enum  JamInvocationType {
    case floating
    case shake
}

typealias JBB = JamBugBuster

final class JamBugBuster {
        
    static var shared = JamBugBuster()
    
    fileprivate var invocationType:JamInvocationType = .shake
    
    /// Method that invokes the JBB framework
    /// - Parameter invocationType: invocation type could be enum of `JamInvocationType`.
    func activate(invocationType: JamInvocationType) {
        self.invocationType = invocationType
        setupInvocationMethod()
    }
    
    private func captureDeviceInfo() {
        var deviceLogger = JamDeviceLogger()
        deviceLogger.getDeviceInfo()
        
        NSLog("JBB: \(deviceLogger)")
        
        JBBShareExtension().shareImage(data: deviceLogger)
    }
}

extension JBB {
    private func setupInvocationMethod() {
        switch invocationType {
        
        case .floating:
            setupFloatingButton()
        case .shake:
            setupShakeInvocker()
        }
    }
    
    private func setupFloatingButton() {
        
    }
    
    private func setupShakeInvocker() {
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "deviceDidShakeNotification"), object: nil, queue: nil) { _ in
            self.didDeviceShaked()
        }
    }
    
    
    private func didDeviceShaked() {
       print("Device shaked")
        captureDeviceInfo()
        
    }
}
