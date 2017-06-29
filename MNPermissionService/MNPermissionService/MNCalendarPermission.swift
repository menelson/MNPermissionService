//
//  MNCalendarPermission.swift
//  MNPermissionService
//
//  Created by Mike Nelson 80044 on 6/29/17.
//
//

import Foundation
import EventKit
import UIKit

class MNCalendarPermission: MNPermissionService, MNPermissionFactory {
    typealias EntityType = EKEntityType
    typealias StoreType = EKEventStore
    
    var store = EKEventStore()
    var entity = EKEntityType.event
    var message: String = "We need these"
    var title = "Calendar Settings"
    
    internal init() {
        super.init(message: message, title: title)
    }
    
    func requestAccess() -> (Bool) {
        if EKEventStore.authorizationStatus(for: .event) == EKAuthorizationStatus.denied {
            repromptUserOfServiceNeed()
        } else {
            store.requestAccess(to: entity) { (accessGranted, error) in
                if error != nil {
                    print("Error requesting Access")
                }
            }
        }
        
        return false
    }
    
    func repromptUserOfServiceNeed() {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: {
            action in
            
            let settingsURL = URL(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.open(settingsURL!, options: [:], completionHandler: nil)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        dialog.addAction(settingsAction)
        dialog.addAction(cancelAction)
        
        if var currentViewController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = currentViewController.presentedViewController {
                currentViewController = presentedViewController
            }
            currentViewController.present(dialog, animated: true, completion: nil)
        }
    }
}
