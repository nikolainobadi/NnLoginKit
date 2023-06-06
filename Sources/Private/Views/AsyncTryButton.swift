//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

internal struct AsyncTryButton<Label>: View where Label: View {
    var action: () async throws -> Void
    var role: ButtonRole?
    @ViewBuilder var label: () -> Label
    @EnvironmentObject var loadingHandler: LoadingHandler
    @EnvironmentObject var errorHandler: LoginErrorHandler
    
    func performAction() {
        loadingHandler.startLoading()
        Task {
            do {
                try await action()
            } catch {
                errorHandler.handle(error: error)
            }
            
            loadingHandler.stopLoading()
        }
    }
    
    var body: some View {
        Button(role: role, action: performAction, label: label)
    }
}


// MARK: - Init
extension AsyncTryButton where Label == Text {
    init(_ titleKey: LocalizedStringKey, role: ButtonRole? = nil, action: @escaping () async throws -> Void) {
        self.init(action: action, role: role, label: { Text(titleKey) })
    }

    init<S>(_ title: S, role: ButtonRole? = nil, action: @escaping () async throws -> Void) where S: StringProtocol {
        self.init(action: action, role: role, label: { Text(title) })
    }
}

internal struct NoLoadingAsyncTryButton<Label>: View where Label: View {
    var action: () async throws -> Void
    var role: ButtonRole?
    @ViewBuilder var label: () -> Label
    @EnvironmentObject var errorHandler: LoginErrorHandler
    
    func performAction() {
        Task {
            do {
                try await action()
            } catch {
                errorHandler.handle(error: error)
            }
        }
    }
    
    var body: some View {
        Button(role: role, action: performAction, label: label)
    }
}


// MARK: - Init
extension NoLoadingAsyncTryButton where Label == Text {
    init(_ titleKey: LocalizedStringKey, role: ButtonRole? = nil, action: @escaping () async throws -> Void) {
        self.init(action: action, role: role, label: { Text(titleKey) })
    }

    init<S>(_ title: S, role: ButtonRole? = nil, action: @escaping () async throws -> Void) where S: StringProtocol {
        self.init(action: action, role: role, label: { Text(title) })
    }
}
