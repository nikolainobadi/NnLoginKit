//
//  ResetPassswordRootViewTests.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import XCTest
import TestHelpers
@testable import ResetPasswordUI

final class ResetPassswordRootViewTests: XCTestCase {
    
    func test_closeButton() {
        let exp = expectation(description: "waiting for dismiss...")
        let sut = makeSUT(finished: { exp.fulfill() })
        
        sut.closeButton.sendActions(for: [.touchUpInside])
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_resetButton() {
        let exp = expectation(description: "waiting for dismiss...")
        let sut = makeSUT(resetPassword: { exp.fulfill() })
        
        sut.resetPasswordButton.sendActions(for: [.touchUpInside])
        
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension ResetPassswordRootViewTests {
    
    func makeSUT(finished: @escaping () -> Void = { },
                 resetPassword: @escaping () -> Void = { },
                 file: StaticString = #filePath, line: UInt = #line) -> ResetPasswordRootView {
        
        let sut = ResetPasswordRootView(config: makeConfig(),
                                        responder: (finished, resetPassword))
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
    
    func makeConfig() -> ResetPasswordViewConfig {
        ResetPasswordViewConfig(titleColor: .label,
                                buttonColor: .label,
                                buttonTextColor: .systemBackground,
                                backgroundColor: .systemBackground)
    }
}
