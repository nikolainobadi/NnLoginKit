//
//  ResetPasswordManagerTests.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import XCTest
import TestHelpers
import ResetPasswordLogic

final class ResetPasswordManagerTests: XCTestCase {
    
    func test_init() {
        let (_, alerts, _) = makeSUT()
        
        XCTAssertNil(alerts.error)
        XCTAssertNil(alerts.errorMessage )
    }
    
    func test_resetPassword_invalidEmail() {
        let (sut, alerts, _) = makeSUT()
        
        sut.resetPassword("")
        XCTAssertNotNil(alerts.errorMessage)
        
        alerts.errorMessage = nil
        XCTAssertNil(alerts.errorMessage)
        
        sut.resetPassword("tester")
        XCTAssertNotNil(alerts.errorMessage)
    }
    
    func test_resetPassword_error() {
        let (sut, alerts, auth) = makeSUT()
        let error = NSError(domain: "Test", code: 0)
        
        sut.resetPassword("tester@gmail.com")
        auth.complete(with: error)
        
        XCTAssertNotNil(alerts.error)
    }
    
    func test_resetPassword_success() {
        let exp = expectation(description: "waiting for dismiss...")
        let (sut, _, auth) = makeSUT { exp.fulfill() }
        
        sut.resetPassword("tester@gmail.com")
        auth.complete(with: nil)
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension ResetPasswordManagerTests {
    
    func makeSUT(dismiss: @escaping () -> Void = { },
                 file: StaticString = #filePath, line: UInt = #line) -> (sut: ResetPasswordManager, alerts: MockResetPasswordAlerts, auth: ResetAuthorizerSpy) {
        
        let auth = ResetAuthorizerSpy()
        let alerts = MockResetPasswordAlerts()
        let sut = ResetPasswordManager(auth: auth,
                                       alerts: alerts,
                                       dismiss: dismiss)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, alerts, auth)
    }
}

// MARK: - Helper Classes
extension ResetPasswordManagerTests {
    
    class ResetAuthorizerSpy: ResetAuthorizer {
        
        private var completion: ((Error?) -> Void)?
        
        func resetPassword(_ email: String, completion: @escaping (Error?) -> Void) {
            self.completion = completion
        }
        
        func complete(with error: Error?,
                      file: StaticString = #filePath, line: UInt = #line) {
            guard
                let completion = completion
            else {
                return XCTFail("no request made", file: file, line: line)
            }
            
            completion(error)
        }
    }
    
    class MockResetPasswordAlerts: ResetPasswordAlerts {
        
        var error: Error?
        var errorMessage: String?
        
        func showError(_ error: Error) {
            self.error = error
        }
        
        func showErrorMessage(_ message: String) {
            self.errorMessage = message
        }
        
        func showDidSendEmailAlert(completion: @escaping () -> Void) {
            completion()
        }
    }
}
