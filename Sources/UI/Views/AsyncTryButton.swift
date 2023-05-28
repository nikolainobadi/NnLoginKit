//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

internal struct AsyncTryButton<Label>: View where Label: View {
    var action: () async throws -> Void
    @ViewBuilder var label: () -> Label
    @EnvironmentObject var loadingHandler: LoadingHandler
    @EnvironmentObject var errorHandler: LoginErrorHandler
    
    var body: some View {
        Button(action: performAction, label: label)
    }
}


// MARK: - Init
extension AsyncTryButton where Label == Text {
    init(_ titleKey: LocalizedStringKey, action: @escaping () async throws -> Void) {
        self.init(action: action, label: { Text(titleKey) })
    }

    init<S>(_ title: S, action: @escaping () async throws -> Void) where S: StringProtocol {
        self.init(action: action, label: { Text(title) })
    }
}


// MARK: - Private Methods
private extension AsyncTryButton {
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
}
