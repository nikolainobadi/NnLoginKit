//
//  LoginVCTests.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import XCTest
import LoginUI
import Combine
import TestHelpers

final class LoginVCTests: XCTestCase {
    
    func test_viewDidLoad_defaultViewModel() {
        let (_, view) = makeSUT()
        
        verify(view)
    }
    
    func test_emailPublisher_emailError() {
        let (_, view) = makeSUT()
        
        verify(view, expectedEmailError: "Invalid email format") {
            view.email = "invalid"
        }
    }
    
    func test_emailPublisher_noError() {
        let (_, view) = makeSUT()
        
        verify(view, expectedEmailError: "") {
            view.email = "tester@gmail.com"
        }
    }
    
    func test_passwordPublisher_passwordError() {
        let (_, view) = makeSUT()
        
        verify(view, expectedPasswordError: "Password too short") {
            view.password = "tes"
        }
    }
    
    func test_passwordPublisher_noError() {
        let (_, view) = makeSUT()
        
        verify(view, expectedPasswordError: "") {
            view.password = "tester"
        }
    }
    
    func test_confirmPublisher_confirmError() {
        let (_, view) = makeSUT()

        verify(view, expectedConfirmError: "Passwords don't match") {
            view.password = "tester"
            view.confirm = "notTheSame"
        }
    }
    
    func test_confirmPublisher_emptyPassword_confirmError() {
        let (_, view) = makeSUT()

        verify(view, expectedConfirmError: "Passwords don't match") {
            view.password = ""
            view.confirm = "tester"
        }
    }

    func test_confirmPublisher_noError() {
        let (_, view) = makeSUT()
        let pwd = "tester"

        verify(view, expectedConfirmError: "") {
            view.password = pwd
            view.confirm = pwd
        }
    }
    
    func test_isSignUpPublisher() {
        let (_, view) = makeSUT()

        verify(view, expectedIsSignUp: false) {
            view.isSignUp = false
        }
    }
    
    func test_isReady_isSignUp() {
        let (_, view) = makeSUT()
        
        verify(view, expectedIsReady: true) {
            view.email = "tester@gmail.com"
            view.password = "tester"
            view.confirm = "tester"
        }
    }
    
    func test_isReady_notIsSignUp() {
        let (_, view) = makeSUT()
        
        verify(view, expectedIsSignUp: false, expectedIsReady: true) {
            view.email = "tester@gmail.com"
            view.password = "tester"
            view.isSignUp = false
        }
    }
}


// MARK: - Assertion Helpers
extension LoginVCTests {
    
    func verify(_ view: MockLoginInterface,
                expectedEmailError: String = "",
                expectedPasswordError: String = "",
                expectedConfirmError: String = "",
                expectedIsSignUp: Bool = true,
                expectedIsReady: Bool = false,
                when action: (() -> Void)? = nil,
                file: StaticString = #filePath, line: UInt = #line) {
        
        action?()
        
        guard let viewModel = view.viewModel else {
            return XCTFail("expected view model", file: file, line: line)
        }
        
        XCTAssertEqual(viewModel.isSignUp, expectedIsSignUp)
        XCTAssertEqual(viewModel.emailError, expectedEmailError)
        XCTAssertEqual(viewModel.passwordError, expectedPasswordError)
        XCTAssertEqual(viewModel.confirmError, expectedConfirmError)
        XCTAssertEqual(viewModel.ready, expectedIsReady)
    }
}


// MARK: - SUT
extension LoginVCTests {
    
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LoginVC, view: MockLoginInterface) {
        
        let rootView = MockLoginInterface()
        let presenter = LoginPresentationAdapter()
        let sut = LoginVC(rootView: rootView, presenter: presenter, fieldsToObserve: [])
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, rootView)
    }
}


// MARK: - Helper Classes
extension LoginVCTests {
    
    class MockLoginInterface: UIView, LoginInterface {
        
        @Published var email: String?
        @Published var password: String?
        @Published var confirm: String?
        @Published var isSignUp: Bool?
        
        var viewModel: LoginViewModel?
        
        var emailPublisher: AnyPublisher<String, Never> {
            $email.compactMap({ $0 }).eraseToAnyPublisher()
        }
        
        var passwordPublisher: AnyPublisher<String, Never> {
            $password.compactMap({ $0 }).eraseToAnyPublisher()
        }
        
        var confirmPublisher: AnyPublisher<String, Never> {
            $confirm.compactMap({ $0 }).eraseToAnyPublisher()
        }
        
        var isSignUpPublisher: AnyPublisher<Bool, Never> {
            $isSignUp.compactMap({ $0 }).eraseToAnyPublisher()
        }
        
        func updateView(_ viewModel: LoginViewModel) {
            self.viewModel = viewModel
        }
    }
}
