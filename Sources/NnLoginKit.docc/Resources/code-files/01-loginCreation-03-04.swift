//
//  ContentView.swift
//  
//
//  Created by Nikolai Nobadi on 6/12/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        LoginComposer.composeLoginView()
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
