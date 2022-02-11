//
//  ResetPasswordVC.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit
import NnUIKitHelpers

public final class ResetPasswordVC: NnViewController {
    
    // MARK: - Properties
    private let rootView: UIView
    
    
    // MARK: - Init
    public init(rootView: UIView, fieldsToObserve: [UITextField] = []) {
        self.rootView = rootView
        super.init(hasTextFields: true, fieldsToObserve: fieldsToObserve)
    }
    
    
    // MARK: - Life Cycle
    public override func loadView() {
        view = rootView
    }
}
