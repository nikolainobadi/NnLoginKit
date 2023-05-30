//
//  LoadingViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

internal struct LoadingViewModifier: ViewModifier {
    @StateObject var loadingHandler = LoadingHandler()

    func body(content: Content) -> some View {
        ZStack {
            content
                .environmentObject(loadingHandler)
            
            if loadingHandler.isLoading {
                ZStack {
                    Color.primary
                        .opacity(0.5)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .accentColor(.white)
                        .scaleEffect(3)
                }
            }
        }
    }
}


// MARK: - ViewExtension
internal extension View {
    func withLoadingView() -> some View {
        modifier(LoadingViewModifier())
    }
}


// MARK: - Dependencies
internal final class LoadingHandler: ObservableObject {
    @Published var isLoading: Bool = false

    func startLoading() {
        isLoading = true
    }

    func stopLoading() {
        isLoading = false
    }
}
