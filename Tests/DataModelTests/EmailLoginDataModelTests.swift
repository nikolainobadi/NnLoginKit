//
//  EmailLoginDataModelTests.swift
//  
//
//  Created by Nikolai Nobadi on 5/31/23.
//

import XCTest
@testable import NnLoginKit

final class EmailLoginDataModelTests: XCTestCase {
    func test_init_startingValuesEmpty() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.email.isEmpty)
        XCTAssertTrue(sut.password.isEmpty)
        XCTAssertTrue(sut.confirm.isEmpty)
        XCTAssertNil(sut.loginFieldError)
        XCTAssertNil(sut.loginErrorMessage)
    }
    
    func test_canShowResetPassword_sendResetEmailIsNil_returnsFalse() {
        XCTAssertFalse(makeSUT().canShowResetPassword)
    }
    
    func test_canShowResetPassword_sendResetEmailIsNotNil_returnsTrue() {
        XCTAssertTrue(makeSUT(sendResetEmail: { _ in }).canShowResetPassword)
    }
    
    func test_tryLogin_emailIsEmpty_loginFieldErrorIsEmail_noErrorThrown() async {
        let sut = makeSUT()
        
        do {
            try await sut.tryLogin()
        
            XCTAssertEqual(sut.loginFieldError, .email)
        } catch {
            XCTFail("unexpeceted error")
        }
    }
    
    func test_tryLogin_emailIsInvalid_loginFieldErrorIsEmail_noErrorThrown() async {
        let sut = makeSUT()
        
        sut.email = "tester@gmail"
        
        do {
            try await sut.tryLogin()
        
            XCTAssertEqual(sut.loginFieldError, .email)
        } catch {
            XCTFail("unexpeceted error")
        }
    }
    
    func test_tryLogin_emailIsValid_passwordIsEmpty_loginFieldErrorIsPassword_noErrorThrown() async {
        let sut = makeSUT()
        
        sut.email = "tester@gmail.com"
        
        do {
            try await sut.tryLogin()
        
            XCTAssertEqual(sut.loginFieldError, .password)
        } catch {
            XCTFail("unexpeceted error")
        }
    }
    
    func test_tryLogin_emailIsValid_passwordIsInvalid_loginFieldErrorIsPassword_noErrorThrown() async {
        let sut = makeSUT()
        
        sut.email = "tester@gmail.com"
        sut.password = "123"
        
        do {
            try await sut.tryLogin()
        
            XCTAssertEqual(sut.loginFieldError, .password)
        } catch {
            XCTFail("unexpeceted error")
        }
    }
    
    func test_tryLogin_emailIsValid_passwordIsValid_sendResetEmailIsNotNil_emailLoginThrowsError_errorIsThrown_loginFieldErrorIsPassword_noErrorThrown() async {
        let sut = makeSUT(sendResetEmail: { _ in }) { _, _ in
            throw NSError(domain: "Test", code: 0)
        }
        
        sut.email = "tester@gmail.com"
        sut.password = "123456"
        
        do {
            try await sut.tryLogin()

            XCTFail("expected an error but none were thrown")
        } catch {
            XCTAssertTrue(true)
        }
    }
    
    func test_tryLogin_emailIsValid_passwordIsValid_sendResetEmailIsNotNil_success() async throws {
        let email = "tester@gmail.com"
        let password = "123456"
        let exp = expectation(description: "waiting for login")
        
        let sut = makeSUT(sendResetEmail: { _ in }) { receivedEmail, receivedPwd in
            XCTAssertEqual(receivedEmail, email)
            XCTAssertEqual(receivedPwd, password)
            exp.fulfill()
        }
        
        sut.email = email
        sut.password = password
        
        try await sut.tryLogin()
        
        await waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension EmailLoginDataModelTests {
    func makeSUT(sendResetEmail: ((String) async throws -> Void)? = nil, emailLogin: @escaping (String, String) async throws -> Void = { (_, _) in }, file: StaticString = #filePath, line: UInt = #line) -> EmailLoginDataModel {
        let sut = EmailLoginDataModel(sendResetEmail: sendResetEmail, emailLogin: emailLogin)
        
        return sut
    }
}
