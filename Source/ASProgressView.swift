//
//  ASSpinner.swift
//  superapp
//
//  Created by Amit on 13/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
public class ASProgressView: UIView {
    var container: UIView?
    var spinner: ASProgressSpinner?
    var size = CGSize(width: 50, height: 50)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    public func setup() {
        setupUIElements()
        setupConstraints()
    }
    
    public func setupUIElements() {
        self.container = UIView()
        self.addSubview(self.container.unsafelyUnwrapped)
        
        self.spinner = ASProgressSpinner()
        self.container?.addSubview(self.spinner.unsafelyUnwrapped)
    }
    
    public func setupConstraints() {
        container?.translatesAutoresizingMaskIntoConstraints = false
        container?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        container?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        container?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        spinner?.translatesAutoresizingMaskIntoConstraints = false
        spinner?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        spinner?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        spinner?.centerXAnchor.constraint(equalTo: container.unsafelyUnwrapped.centerXAnchor).isActive = true
        spinner?.centerYAnchor.constraint(equalTo: container.unsafelyUnwrapped.centerYAnchor).isActive = true
    }
    
    public func getSpinner() -> ASProgressSpinner? {
        return spinner
    }
}

@available(iOS 9.0, *)
extension ASProgressView {
}
