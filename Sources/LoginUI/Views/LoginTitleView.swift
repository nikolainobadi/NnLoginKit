//
//  LoginTitleView.swift
//  
//
//  Created by Nikolai Nobadi on 2/10/22.
//

import UIKit
import NnUIKitHelpers

public final class LoginTitleView: NnView {
    
    // MARK: - Properties
    private let imageView: UIView
    private let titleColor: UIColor?
    
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        UILabel()
            .setColor(titleColor)
            .setAlignment(.center)
            .addShadow()
            .autoSize()
            .setFontByStyle(.largeTitle)
    }()
    
    
    // MARK: - Init
    public init(imageView: UIView, titleColor: UIColor?) {
        self.imageView = imageView
        self.titleColor = titleColor
        super.init(color: .clear)
    }
    
    
    // MARK: - Display Setup
    public override func addSubviews() {
        addSubview(titleLabel)
        addSubview(imageView)
    }
    
    public override func setupConstraints() {
        titleLabel.anchor(topAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          topConstant: heightPercent(1),
                          leftConstant: widthPercent(3),
                          rightConstant: widthPercent(3))
        
        imageView.anchor(titleLabel.bottomAnchor,
                          left: leftAnchor,
                          bottom: safeBottomAnchor,
                          right: rightAnchor,
                          leftConstant: widthPercent(2),
                          rightConstant: widthPercent(2))
    }
}


// MARK: - Helper Methods
extension LoginTitleView {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
