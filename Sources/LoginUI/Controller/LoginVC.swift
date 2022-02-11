//
//  LoginVC.swift
//  
//
//  Created by Nikolai Nobadi on 2/9/22.
//

import UIKit
import Combine
import LoginLogic
import NnUIKitHelpers

public final class LoginVC: NnViewController {

    // MARK: - Properties
    private let rootView: LoginInterface
    private let presenter: LoginPresenter
    
    private var changes = Set<AnyCancellable>()
    
    
    // MARK: - Init
    public init(rootView: LoginInterface,
                presenter: LoginPresenter,
                fieldsToObserve: [UITextField]?) {
        
        self.rootView = rootView
        self.presenter = presenter
        super.init(hasTextFields: true, fieldsToObserve: fieldsToObserve)
    }
    
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        startObservers()
    }
    
    public override func loadView() {
        view = rootView
    }
}


// MARK: - Private Methods
private extension LoginVC {
    
    func startObservers() {
        guard changes.isEmpty else { return }
        
        presenter.viewModelPublisher
            .sink { [weak self] in self?.rootView.updateView($0) }
            .store(in: &changes)
        
        rootView.emailPublisher
            .sink { [weak self] in self?.presenter.updateEmail($0) }
            .store(in: &changes)
        
        rootView.passwordPublisher
            .sink { [weak self] in self?.presenter.updatePassword($0) }
            .store(in: &changes)
        
        rootView.confirmPublisher
            .sink { [weak self] in self?.presenter.updateConfirm($0) }
            .store(in: &changes)
        
        rootView.isSignUpPublisher
            .sink { [weak self] in self?.presenter.updateIsSignUp($0) }
            .store(in: &changes)
    }
}


// MARK: - Dependencies
public protocol LoginPresenter {
    var viewModelPublisher: AnyPublisher<LoginViewModel, Never> { get }
    
    func updateEmail(_ email: String)
    func updatePassword(_ password: String)
    func updateConfirm(_ confirm: String)
    func updateIsSignUp(_ isSignUp: Bool)
}

public protocol LoginInterface: UIView {
    var emailPublisher: AnyPublisher<String, Never> { get }
    var passwordPublisher: AnyPublisher<String, Never> { get }
    var confirmPublisher: AnyPublisher<String, Never> { get }
    var isSignUpPublisher: AnyPublisher<Bool, Never> { get }
    
    func updateView(_ viewModel: LoginViewModel)
}
