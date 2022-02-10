//
//  LoginFieldViewTests.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import XCTest
import TestHelpers
@testable import LoginUI

final class LoginFieldViewTests: XCTestCase {
    
    func test_forgotPassword() {
        let exp = expectation(description: "waiting for action...")
        let sut = makeSUT(forgotPassword: { exp.fulfill() })
        
        sut.forgotPasswordButton.sendActions(for: [.touchUpInside])
        
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension LoginFieldViewTests {
    
    func makeSUT(emailSignIn: @escaping () -> Void = { },
                 forgotPassword: @escaping () -> Void = { },
                 file: StaticString = #filePath, line: UInt = #line) -> LoginFieldsView {
        
        let sut = LoginFieldsView(emailSignIn: emailSignIn,
                                  forgotPassword: forgotPassword)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
}
