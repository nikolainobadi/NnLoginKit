//
//  LoginManagerTests.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import XCTest
import LoginLogic
import TestHelpers

final class LoginManagerTests: XCTestCase {
    
    func test_guestSignIn_error() {
        let (sut, alerts, auth) = makeSUT()
        let error = NSError(domain: "Test", code: 0)
        
        sut.guestLogin()
        auth.complete(with: error)
        XCTAssertNotNil(alerts.error)
    }
    
    func test_guestSignIn_success() {
        let exp = expectation(description: "waiting for session")
        let session = makeSession(isGuest: true, isNewUser: true)
        let (sut, _, auth) = makeSUT { recievedSession in
            XCTAssertEqual(recievedSession, session); exp.fulfill()
        }
        
        
        sut.guestLogin()
        auth.complete(session)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_emailSignIn_error() {
        let (sut, alerts, auth) = makeSUT()
        let error = NSError(domain: "Test", code: 0)
        
        sut.emailSignIn()
        auth.complete(with: error)
        XCTAssertNotNil(alerts.error)
    }
    
    func test_emailSignIn_newUser_success() {
        let exp = expectation(description: "waiting for session")
        let session = makeSession(isNewUser: true)
        let info = MockLoginInfo(isSignUp: true)
        let (sut, _, auth) = makeSUT(info: info) { recievedSession in
            XCTAssertEqual(recievedSession, session); exp.fulfill()
        }
        
        sut.emailSignIn()
        auth.complete(session, expectedIsSignUp: true)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_emailSignIn_success() {
        let exp = expectation(description: "waiting for session")
        let session = makeSession()
        let info = MockLoginInfo(isSignUp: false)
        let (sut, _, auth) = makeSUT(info: info) { recievedSession in
            XCTAssertEqual(recievedSession, session); exp.fulfill()
        }
        
        sut.emailSignIn()
        auth.complete(session, expectedIsSignUp: false)
        
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension LoginManagerTests {
    
    func makeSUT(info: LoginInfo = MockLoginInfo(),
                 finished: @escaping (UserSessionInfo) -> Void = { _ in },
                 file: StaticString = #filePath, line: UInt = #line) -> (sut: LoginManager, alerts: MockLoginAlerts, auth: EmailAuthorizerSpy) {
        
        let alerts = MockLoginAlerts()
        let auth = EmailAuthorizerSpy()
        let sut = LoginManager(info: info,
                               auth: auth,
                               alerts: alerts,
                               finished: finished)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, alerts, auth)
    }
    
    func makeSession(userId: String? = nil,
                     isGuest: Bool = false,
                     isNewUser: Bool = false) -> UserSessionInfo {
        
        UserSessionInfo(userId: userId ?? getTestName(.testUserId),
                        isGuest: isGuest,
                        isNewUser: isNewUser)
    }
}


// MARK: - Helper Classes
extension LoginManagerTests {
    
    class MockLoginInfo: LoginInfo {
        var email: String = "tester@gmail.com"
        var password: String = "tester"
        var isSignUp: Bool
        
        init(isSignUp: Bool = true) {
            self.isSignUp = isSignUp
        }
    }
    
    class MockLoginAlerts: LoginAlerts {
        
        var error: Error?
        
        func showError(_ error: Error) {
            self.error = error
        }
    }
    
    class EmailAuthorizerSpy: EmailAuthorizer {
        
        var isSignUp = true
        private var completion: ((Result<UserSessionInfo, Error>) -> Void)?
        
        func guestSignIn(completion: @escaping (Result<UserSessionInfo, Error>) -> Void) {
            
            self.completion = completion
        }
        
        func signIn(email: String,
                    password: String,
                    isSignUp: Bool,
                    completion: @escaping (Result<UserSessionInfo, Error>) -> Void) {
            
            self.isSignUp = isSignUp
            self.completion = completion
        }
        
        func complete(with error: Error,
                      file: StaticString = #filePath, line: UInt = #line) {
            guard
                let completion = completion
            else {
                return XCTFail("no request made", file: file, line: line)
            }
            
            completion(.failure(error))
        }
        
        func complete(_ session: UserSessionInfo,
                      expectedIsSignUp: Bool = true,
                      file: StaticString = #filePath, line: UInt = #line) {
            guard
                let completion = completion
            else {
                return XCTFail("no request made", file: file, line: line)
            }
            
            XCTAssertEqual(isSignUp, expectedIsSignUp)
            completion(.success(session))
        }
    }
}
