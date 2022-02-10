//
//  LoginVC.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import NnUIKitHelpers

public final class LoginVC: NnViewController {

    // MARK: - Properties
    private let rootView: UIView
    
    
    // MARK: - Init
    public init(rootView: UIView) {
        self.rootView = rootView
        super.init(hasTextFields: true, withKeyboardObserver: true)
    }
    
    
    // MARK: - Life Cycle
    public override func loadView() {
        view = rootView
    }
}
