//
//  LoginTextField.swift
//  
//
//  Created by Nikolai Nobadi on 5/27/23.
//

import SwiftUI

struct LoginTextField: View {
    @Binding var text: String
    @State private var isSecured: Bool
    
    let imageName: String
    let prompt: String
    let canBeSecure: Bool
    let keyboard: UIKeyboardType
    let imageTint: Color
    
    private var eyeImage: String { isSecured ? "eye.slash" : "eye" }
    
    init(text: Binding<String>, imageName: String, prompt: String, canBeSecure: Bool = false, keyboard: UIKeyboardType = .asciiCapable, imageTint: Color = .blue) {
        self._text = text
        self.imageName = imageName
        self.prompt = prompt
        self.canBeSecure = canBeSecure
        self.isSecured = canBeSecure
        self.keyboard = keyboard
        self.imageTint = imageTint
    }
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            
            if isSecured {
                SecureField("", text: $text, prompt: Text(prompt))
                    .font(.title2)
                    .keyboardType(keyboard)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            } else {
                TextField("", text: $text, prompt: Text(prompt))
                    .font(.title2)
                    .keyboardType(keyboard)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
            
            if canBeSecure {
                Button(action: { isSecured.toggle() }) {
                    Image(systemName: eyeImage)
                        .tint(imageTint)
                }
            }
        }
        .padding(5)
        .accentColor(.primary)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: .primary, radius: 2)
    }
}


// MARK: - Preview
struct LoginTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginTextField(text: .constant(""), imageName: "", prompt: "")
    }
}
