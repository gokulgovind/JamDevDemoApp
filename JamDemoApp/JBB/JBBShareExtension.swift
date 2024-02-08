//
//  JBBShareExtension.swift
//  JamDemoApp
//
//  Created by Gokul on 08/02/24.
//

import Foundation
import SwiftUI



final class JBBShareExtension {
    func shareImage(data: JamDeviceLogger) {
        guard let image = data.appScreenShot else {return}
        
        var mutableData = data
        var sharableJson:String?
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: mutableData.shareContent,
            options: []) {
            sharableJson = String(data: theJSONData,
                                       encoding: .ascii)
        }
        
        var sharableItems: [Any] = [image]
        if let unwrappedString = sharableJson {
            sharableItems.append(unwrappedString)
        }
        let activityVC = UIActivityViewController(activityItems: sharableItems, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}
