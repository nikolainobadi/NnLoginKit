//
//  LoginKitComposite.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import LoginUI
import LoginLogic
import ResetPasswordUI
import ResetPasswordLogic

public final class LoginKitComposite {
    private init() { }
    
    public static func makeLoginVC(auth: EmailAuthorizer,
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
        
        return LoginVC(rootView: rootView,
                       presenter: presenter,
                       fieldsToObserve: fieldsview.fields)
    }
    
    public static func makeResetPasswordVC(auth: ResetAuthorizer,
                                           alerts: ResetPasswordAlerts,
                                           config: ResetPasswordViewConfig,
                                           dismiss: @escaping () -> Void) -> UIViewController {
        
        let manager = ResetPasswordManager(auth: auth,
                                           alerts: alerts,
                                           dismiss: dismiss)
    
        let rootView = ResetPasswordRootView(
            config: config,
            responder: (finished: dismiss,
                        resetPassword: manager.resetPassword(_:)))
        
        return ResetPasswordVC(rootView: rootView)
    }
}


// MARK: - Private Methods
private extension LoginKitComposite {
    
    static func makeEmptyView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }
}
