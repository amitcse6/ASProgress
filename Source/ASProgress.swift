//
//  ASProgress.swift
//  superapp
//
//  Created by Amit on 12/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
public class ASProgress {
    static var sharedManager: ASProgress?
    
    private var progressView: ASProgressView?
    private var rootPadding: CGFloat = 16
    private var withDuration: TimeInterval = 3
    private var delay: TimeInterval = 1
    
    @discardableResult
    private static func shared() -> ASProgress? {
        if sharedManager == nil {
            sharedManager = ASProgress()
        }
        return sharedManager
    }
    
    private init() {
    }
    
    func show() {
        if let viewController = ASProgress.topMostVC {
            progressView = ASProgressView()
            viewController.view.addSubview(progressView.unsafelyUnwrapped)
            progressView?.backgroundColor = .clear
            if #available(iOS 11.0, *) {
                progressView?.translatesAutoresizingMaskIntoConstraints = false
                progressView?.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
                progressView?.leftAnchor.constraint(equalTo: viewController.view.leftAnchor).isActive = true
                progressView?.rightAnchor.constraint(equalTo: viewController.view.rightAnchor).isActive = true
                progressView?.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
                gesture.numberOfTapsRequired = 1
                progressView?.addGestureRecognizer(gesture)
                progressView?.isUserInteractionEnabled = true
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @objc func onTap(sender : AnyObject){
    }
    
    func dismiss(_ progressView: ASProgressView?) {
        var progressView = progressView
        progressView?.getSpinner()?.layer.removeAllAnimations()
        progressView?.removeFromSuperview()
        progressView = nil
    }
    
    @objc private func dismissWithAnimation(_ progressView: ASProgressView?) {
        UIView.animate(withDuration: withDuration, delay: delay, options: [.allowUserInteraction], animations: { () -> Void in
            //spinner?.container?.alpha = 0
        }, completion: { (finished) in
            self.dismiss(progressView)
        })
    }
}

@available(iOS 9.0, *)
extension ASProgress {
    public static func show() {
        if let progress = ASProgress.shared() {
            ASProgress.dismiss()
            progress.show()
        }
    }
    
    public static func dismiss() {
        if let progress = ASProgress.shared() {
            progress.dismiss(progress.progressView)
        }
    }
    
    private static var topMostVC: UIViewController? {
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        if presentedVC == nil {
            print("Error: You don't have any views set.")
        }
        return presentedVC
    }
}
