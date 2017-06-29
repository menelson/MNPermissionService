//
//  PermissionProtocol.swift
//  MNPermissionService
//
//  Created by Mike Nelson 80044 on 6/29/17.
//
//

import Foundation
import EventKit
import Contacts
import UIKit

protocol PermissionFactory {
    associatedtype EntityType
    associatedtype StoreType
    
    var store: StoreType { get }
    var entity: EntityType { get }
    var message: String { get }
    var title: String { get }
    
    func requestAccess() -> Bool
    func repromptUserOfServiceNeed()
}

public enum ServicePermission {
    case calendar
    case contact
}

public class PermissionService {
    fileprivate var messageInternal: String?
    fileprivate var titleInternal: String?
    
    fileprivate init(message: String, title: String) {
        self.messageInternal = message
        self.titleInternal = title
    }
    
    //    public class func create(service: ServicePermission) -> PermissionService {
    //        var result: PermissionService
    //
    //        switch service {
    //        case .calendar:
    //            result = CalendarPermission()
    //            break
    //        case .contact:
    //            result = ContactPermission()
    //            break
    //        }
    //
    //        return result
    //    }
    
    // Dialog for when permissions not granted but feature would require it.
    //    func repromptUserofServiceNeed() {
    //
    //        let dialog = UIAlertController(title: self.titleInternal, message: self.messageInternal, preferredStyle: .alert)
    //
    //        let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: {
    //            action in
    //
    //            let settingsURL = URL(string: UIApplicationOpenSettingsURLString)
    //            UIApplication.shared.open(settingsURL!, options: [:], completionHandler: nil)
    //
    //        })
    //
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    //
    //        dialog.addAction(settingsAction)
    //        dialog.addAction(cancelAction)
    //
    //        if var currentViewController = UIApplication.shared.keyWindow?.rootViewController {
    //            while let presentedViewController = currentViewController.presentedViewController {
    //                currentViewController = presentedViewController
    //            }
    //            currentViewController.present(dialog, animated: true, completion: nil)
    //        }
    //    }
}



class CalendarPermission: PermissionFactory {
    typealias EntityType = EKEntityType
    typealias StoreType = EKEventStore
    
    var store = EKEventStore()
    var entity = EKEntityType.event
    var message: String = "We need these"
    var title = "Calendar Settings"
    
    init() {
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

class ContactPermission: PermissionFactory {
    typealias EntityType = CNEntityType
    typealias StoreType = CNContactStore
    
    var store = CNContactStore()
    var entity = CNEntityType.contacts
    var message = "I need this too"
    var title = "Contact Settings"
    
    func requestAccess() -> Bool {
        
        if CNContactStore.authorizationStatus(for: .contacts) == CNAuthorizationStatus.denied {
            repromptUserOfServiceNeed()
        } else {
            store.requestAccess(for: entity, completionHandler: {
                accessGranted, error in
                
                if error != nil {
                    print("Error requesting access")
                }
                
            })
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
