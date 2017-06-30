//
//  MNContactPermissionTests.swift
//  MNPermissionService
//
//  Created by Mike Nelson 80044 on 6/30/17.
//
//

import XCTest
@testable import MNPermissionService

class MNContactPermissionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreate() {
        // Given
        let service: MNPermissionService
        
        // When
        service = MNPermissionService.create(service: .contact)
        
        // Then
        XCTAssertNotNil(service, "Contact Service should not be nil")
    }
    
}
