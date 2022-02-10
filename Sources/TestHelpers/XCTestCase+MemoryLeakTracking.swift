//
//  XCTestCase+MemoryLeakTracking.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import XCTest

public extension XCTestCase {
    
    func trackForMemoryLeaks(_ instance: AnyObject,
                             file: StaticString = #filePath,
                             line: UInt = #line) {
        
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
    
    enum TestName: String {
        case testUserId
        case testUsername
        
        case testHouseId
        case testHouseName
        
        case testRoomId
        case testRoomName
        
        case testTaskId
        case testTaskName
        
        case firstId
        case secondId
        case thirdId
        
        case firstName
        case secondName
        case thirdName
    }
    
    func getTestName(_ value: TestName) -> String {
        value.rawValue
    }
}


