//
//  LoginKitComposite.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import LoginUI
import LoginLogic

public final class LoginKitComposite {
    private init() { }
    
    func makeLoginVC(auth: EmailAuthorizer,
                     alerts: LoginAlerts,
                     config: LoginViewConfig,
                     finished: @escaping (UserSessionInfo) -> Void,
                     showResetPassword: @escaping () -> Void) -> UIViewController {
        
        let presenter = LoginPresentationAdapter()
        let manager = LoginManager(info: presenter,
                                   auth: auth,
                                   alerts: alerts,
                                   finished: finished)
        
        let imageView = config.imageView ?? makeEmptyView()
        let titleView = LoginTitleView(imageView: imageView,
                                       titleColor: config.titleColor)
        
        let fieldsview = LoginFieldsView(emailSignIn: manager.emailSignIn,
                                         forgotPassword: showResetPassword)
        
        let buttonsView = LoginButtonsView(buttonColor: config.buttonColor,
                                           buttonTextColor: config.buttonTextColor,
                                           guestLogin: manager.guestLogin,
                                           emailSignIn: manager.emailSignIn)
        
        let rootView = LoginRootView(titleView: titleView,
                                     fieldsView: fieldsview,
                                     buttonsView: buttonsView,
                                     backgroundColor: config.backgroundColor)
        
        return LoginVC(rootView: rootView, presenter: presenter)
    }
    
    func makeResetPasswordVC() -> UIViewController {
        UIViewController()
    }
    
    private func makeEmptyView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }
}
