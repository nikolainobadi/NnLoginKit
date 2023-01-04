//
//  NnLoginDataModelTests.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/23.
//

import XCTest
@testable import NnLoginKit

final class NnLoginDataModelTests: XCTestCase {
    func test_init_startingValuesEmpty() {
        let (sut, actions) = makeSUT()
        
        XCTAssertTrue(sut.email.isEmpty)
        XCTAssertTrue(sut.password.isEmpty)
        XCTAssertTrue(sut.confirm.isEmpty)
        XCTAssertFalse(sut.isLogin)
        XCTAssertFalse(sut.isLoading)
        
        XCTAssertFalse(actions.guestSignUp)
        XCTAssertNil(actions.loginEmail)
        XCTAssertNil(actions.loginPassword)
        XCTAssertNil(actions.signUpEmail)
        XCTAssertNil(actions.signUpPassword)
    }
    
    func test_title() {
        let sut = makeSUT().sut
        
        XCTAssertEqual(sut.title, "Sign Up")
        
        sut.isLogin = true
        
        XCTAssertEqual(sut.title, "Login")
    }
    
    func test_login_error() async throws {
        let sut = makeSUT(throwError: true).sut
        
        sut.login(shouldSkip: true)
        
        try await waitForAsyncMethod()
        
        XCTAssertNotNil(sut.error)
    }
    
    func test_login_shouldSkip() async throws {
        let (sut, actions) = makeSUT()
        
        sut.login(shouldSkip: true)
        
        try await waitForAsyncMethod()
        
        XCTAssertTrue(actions.guestSignUp)
    }
    
    func test_login_emailError() async throws {
        let sut = makeSUT().sut
        
        sut.login()
        
        try await waitForAsyncMethod()
        
        guard let fieldError = sut.loginFieldError else { return XCTFail("expected error but none were thrown") }
        
        XCTAssertEqual(fieldError, .email)
    }
    
    func test_login_passwordError() async throws {
        let sut = makeSUT().sut
        
        sut.email = validEmail
        sut.login()
        
        try await waitForAsyncMethod()
        
        guard let fieldError = sut.loginFieldError else { return XCTFail("expected error but none were thrown") }
        
        XCTAssertEqual(fieldError, .password)
    }
    
    func test_login_confirmPasswordError() async throws {
        let sut = makeSUT().sut
        
        sut.email = validEmail
        sut.password = validPassword
        sut.login()
        
        try await waitForAsyncMethod()
        
        guard let fieldError = sut.loginFieldError else { return XCTFail("expected error but none were thrown") }
        
        XCTAssertEqual(fieldError, .confirm)
    }
    
    func test_login_signingUp() async throws {
        let (sut, actions) = makeSUT()
        
        sut.email = validEmail
        sut.password = validPassword
        sut.confirm = validPassword
        sut.login()
        
        try await waitForAsyncMethod()
        
        XCTAssertNotNil(actions.signUpEmail)
        XCTAssertNotNil(actions.signUpPassword)
    }
    
    func test_login_loggingIn() async throws {
        let (sut, actions) = makeSUT()
        
        sut.isLogin = true
        sut.email = validEmail
        sut.password = validPassword
        sut.login()
        
        try await waitForAsyncMethod()
        
        XCTAssertNotNil(actions.loginEmail)
        XCTAssertNotNil(actions.loginPassword)
    }
}


// MARK: - SUT
extension NnLoginDataModelTests {
    func makeSUT(throwError: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> (sut: NnLoginDataModel, actions: MockActions) {
        let actions = MockActions(throwError: throwError)
        let sut = NnLoginDataModel(actions: actions)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, actions)
    }
}


// MARK: - Helper Classes
extension NnLoginDataModelTests {
    var validEmail: String { "tester@gmail.com" }
    var validPassword: String { "tester" }
    
    class MockActions: NnLoginActions {
        private let throwError: Bool
        
        var loginEmail: String?
        var loginPassword: String?
        var signUpEmail: String?
        var signUpPassword: String?
        var guestSignUp: Bool = false
        
        init(throwError: Bool) {
            self.throwError = throwError
        }
        
        func guestLogin() async throws {
            if throwError { throw NSError(domain: "Test", code: 0) }
            
            guestSignUp = true
        }
        
        func login(email: String, password: String) async throws {
            if throwError { throw NSError(domain: "Test", code: 0) }
            
            loginEmail = email
            loginPassword = password
        }
        
        func signUp(email: String, password: String) async throws {
            if throwError { throw NSError(domain: "Test", code: 0) }
            
            signUpEmail = email
            signUpPassword = password
        }
    }
}


extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
    
    func waitForAsyncMethod() async throws {
        try await Task.sleep(nanoseconds: 0_010_000_000)
    }
}
