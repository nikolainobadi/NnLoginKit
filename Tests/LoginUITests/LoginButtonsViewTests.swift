//
//  LoginButtonsViewTests.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import XCTest
import TestHelpers
@testable import LoginUI

final class LoginButtonsViewTests: XCTestCase {
    
    func test_init_() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.isSignUp)
        XCTAssertFalse(sut.loginButton.isEnabled)
    }
    
    func test_accountButton_toggleSignUp() {
        let sut = makeSUT()
        
        sut.accountButton.sendActions(for: [.touchUpInside])
        
        XCTAssertFalse(sut.isSignUp)
    }
    
    func test_guestLogin() {
        let exp = expectation(description: "waiting for action...")
        let sut = makeSUT(guestLogin: { exp.fulfill() })
        
        sut.guestLoginButton.sendActions(for: [.touchUpInside])
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_emailSignIn() {
        let exp = expectation(description: "waiting for action...")
        let sut = makeSUT(emailSignIn: { exp.fulfill() })
        
        sut.loginButton.sendActions(for: [.touchUpInside])
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_updateView() {
        let sut = makeSUT()
        
        sut.updateView(isReady: true, loginTitle: "", accountTitle: "")
        
        XCTAssertTrue(sut.loginButton.isEnabled)
    }
}


// MARK: - SUT
extension LoginButtonsViewTests {
    
    func makeSUT(onlySignUp: Bool = false,
                 guestLogin: @escaping () -> Void = { },
                 emailSignIn: @escaping () -> Void = { },
                 file: StaticString = #filePath, line: UInt = #line) -> LoginButtonsView {
        
        let sut = LoginButtonsView(buttonColor: nil,
                                   buttonTextColor: nil,
                                   onlySignUp: onlySignUp,
                                   guestLogin: guestLogin,
                                   emailSignIn: emailSignIn)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
}
