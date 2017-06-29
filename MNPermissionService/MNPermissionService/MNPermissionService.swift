//
//  MNPermissionProtocol.swift
//  MNPermissionService
//
//  Created by Mike Nelson 80044 on 6/29/17.
//
//

import Foundation
import EventKit
import Contacts
import UIKit

public class MNPermissionService {
    fileprivate var messageInternal: String?
    fileprivate var titleInternal: String?
    
    internal init(message: String, title: String) {
        self.messageInternal = message
        self.titleInternal = title
    }
    
    public class func create(service: MNPermissionType) -> MNPermissionService {
        var result: MNPermissionService
        
        switch service {
        case .calendar:
            result = MNCalendarPermission()
            break
        case .contact:
            result = MNContactPermission()
            break
        }
        
        return result
    }
    
    func requestAccess(service: MNPermissionType) {
        
        switch service {
        case .calendar:
            _ = MNCalendarPermission().requestAccess()
            break;
        case .contact:
            _ = MNContactPermission().requestAccess()
            break;
        }
    }
    
}
