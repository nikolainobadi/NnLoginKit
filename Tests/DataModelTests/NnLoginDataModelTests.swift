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
}


// MARK: - SUT
extension NnLoginDataModelTests {
    func makeSUT(throwError: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> (sut: NnLoginDataModel, actions: MockActions) {
        let actions = MockActions(throwError: throwError)
        let sut = NnLoginDataModel(actions: actions)
        
        return (sut, actions)
    }
}


// MARK: - Helper Classes
extension NnLoginDataModelTests {
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
