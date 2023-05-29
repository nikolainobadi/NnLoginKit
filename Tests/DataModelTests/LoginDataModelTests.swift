////
////  LoginDataModelTests.swift
////  
////
////  Created by Nikolai Nobadi on 1/3/23.
////
//
//import XCTest
//@testable import NnLoginKit
//
//final class LoginDataModelTests: XCTestCase {
//    func test_init_startingValuesEmpty() {
//        let sut = makeSUT()
//
//        XCTAssertTrue(sut.email.isEmpty)
//        XCTAssertTrue(sut.password.isEmpty)
//        XCTAssertTrue(sut.confirm.isEmpty)
//        XCTAssertFalse(sut.isLogin)
//        XCTAssertFalse(sut.isLoading)
//    }
//    
//    func test_title() {
//        let sut = makeSUT()
//
//        XCTAssertEqual(sut.title, "Sign Up")
//
//        sut.isLogin = true
//
//        XCTAssertEqual(sut.title, "Login")
//    }
//    
//    func test_login_error() async throws {
//        let sut = makeSUT(guestLogin: { throw NSError(domain: "Test", code: 0) })
//
//        sut.login(shouldSkip: true)
//        
//        try await waitForAsyncMethod()
//        
//        XCTAssertNotNil(sut.error)
//    }
//    
//    func test_login_shouldSkip() async throws {
//        let exp = expectation(description: "waitingn for guest login")
//        let sut = makeSUT(guestLogin: { exp.fulfill() })
//        
//        sut.login(shouldSkip: true)
//
//        await waitForExpectations(timeout: 0.1)
//    }
//    
//    func test_login_emailError() async throws {
//        let sut = makeSUT()
//
//        sut.login()
//
//        try await waitForAsyncMethod()
//
//        guard let fieldError = sut.loginFieldError else { return XCTFail("expected error but none were thrown") }
//
//        XCTAssertEqual(fieldError, .email)
//    }
//    
//    func test_login_passwordError() async throws {
//        let sut = makeSUT()
//
//        sut.email = validEmail
//        sut.login()
//
//        try await waitForAsyncMethod()
//
//        guard let fieldError = sut.loginFieldError else { return XCTFail("expected error but none were thrown") }
//
//        XCTAssertEqual(fieldError, .password)
//    }
//    
//    func test_login_confirmPasswordError() async throws {
//        let sut = makeSUT()
//
//        sut.email = validEmail
//        sut.password = validPassword
//        sut.login()
//
//        try await waitForAsyncMethod()
//
//        guard let fieldError = sut.loginFieldError else { return XCTFail("expected error but none were thrown") }
//
//        XCTAssertEqual(fieldError, .confirm)
//    }
//    
//    func test_login_signingUp() async throws {
//        let email = validEmail
//        let password = validPassword
//        let exp = expectation(description: "waiting for sign up")
//        let sut = makeSUT(emailSignUp: { (recievedEmail, recievedPassword) in
//            XCTAssertEqual(recievedEmail, email)
//            XCTAssertEqual(recievedPassword, password)
//            exp.fulfill()
//        })
//        
//        sut.email = email
//        sut.password = password
//        sut.confirm = password
//        sut.login()
//
//        try await waitForAsyncMethod()
//        
//        await waitForExpectations(timeout: 0.1)
//    }
//    
//    func test_login_loggingIn() async throws {
//        let email = validEmail
//        let password = validPassword
//        let exp = expectation(description: "waiting for sign up")
//        let sut = makeSUT(emailLogin: { (recievedEmail, recievedPassword) in
//            XCTAssertEqual(recievedEmail, email)
//            XCTAssertEqual(recievedPassword, password)
//            exp.fulfill()
//        })
//        
//        sut.isLogin = true
//        sut.email = email
//        sut.password = password
//        sut.login()
//
//        try await waitForAsyncMethod()
//        
//        await waitForExpectations(timeout: 0.1)
//    }
//}
//
//
//// MARK: - SUT
//extension LoginDataModelTests {
//    func makeSUT(guestLogin: (() async throws -> Void)? = nil, emailLogin: ((EmailLoginInfo) async throws -> Void)? = nil, emailSignUp: @escaping (EmailLoginInfo) async throws -> Void = { _ in }, file: StaticString = #filePath, line: UInt = #line) -> LoginDataModel {
//        let sut = LoginDataModel(colorOptions: LoginColorOptions(), guestLogin: guestLogin, emailLogin: emailLogin, emailSignUp: emailSignUp)
//        
//        trackForMemoryLeaks(sut, file: file, line: line)
//        
//        return sut
//    }
//}
//
//
//// MARK: - Helper Classes
//extension LoginDataModelTests {
//    var validEmail: String { "tester@gmail.com" }
//    var validPassword: String { "tester" }
//}
//
//
//extension XCTestCase {
//    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
//        addTeardownBlock { [weak instance] in
//            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
//        }
//    }
//    
//    func waitForAsyncMethod() async throws {
//        try await Task.sleep(nanoseconds: 0_010_000_000)
//    }
//}
