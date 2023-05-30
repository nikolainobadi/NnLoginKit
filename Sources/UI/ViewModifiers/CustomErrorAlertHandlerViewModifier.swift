//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

internal struct CustomErrorAlertHandlerViewModifier: ViewModifier {
    @StateObject var errorHandling = LoginErrorHandler()

    func body(content: Content) -> some View {
        content
            .environmentObject(errorHandling)
            .background(
                EmptyView()
                    .alert(item: $errorHandling.currentAlert) { currentAlert in
                        Alert(
                            title: Text(currentAlert.title),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}


// MARK: - ViewExtension
internal extension View {
    func withErrorHandling() -> some View {
        modifier(CustomErrorAlertHandlerViewModifier())
    }
}


// MARK: - Dependencies
internal struct ErrorAlert: Identifiable {
    var id = UUID()
    var title: String = "Error"
    var message: String = ""
    var dismissAction: (() -> Void)?
}

internal final class LoginErrorHandler: ObservableObject {
    @Published var currentAlert: ErrorAlert?
    
    func handle(error: Error) {
        currentAlert = makeErrorAlert(from: error)
    }
}

private extension LoginErrorHandler {
    func makeErrorAlert(from error: Error) -> ErrorAlert {
        var errorAlert = ErrorAlert()
        
        if let customError = error as? DisplayableLoginError {
            errorAlert.title = customError.title
            errorAlert.message = customError.message
        }
        
        return errorAlert
    }
}
