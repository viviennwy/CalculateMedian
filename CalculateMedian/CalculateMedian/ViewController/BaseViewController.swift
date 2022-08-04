//
//  BaseViewController.swift
//  CalculateMedian
//
//  Created by vivien on 04/08/2022.
//

import UIKit

class BaseViewController: UIViewController {
    private var keyboardAppeared = false
    
    private var viewControllerHeight: CGFloat = 0
    
    func keyboardChangeFrame(isAppear: Bool, keyboardHeight: CGFloat, duration: Double) {
        // For Override the Keyboard Notification Method
        if isAppear {
            if !keyboardAppeared {
                keyboardAppeared = true
            }
            view.frame.size.height = viewControllerHeight - keyboardHeight
        } else {
            if keyboardAppeared {
                keyboardAppeared = false
                view.frame.size.height = viewControllerHeight
            }
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addKeyboardNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addTapGestureDismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func keyboardNotification(notification: NSNotification) {
        if let keyboardInfo = notification.userInfo as NSDictionary? {
            var inset: CGFloat = 0
            if #available(iOS 11.0, *) {
                inset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 //for devices which have safe area
            }
            
            let keyboardHeight = (keyboardInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as AnyObject).cgRectValue.size.height /*- inset*/
            let duration = (keyboardInfo.value(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as AnyObject).doubleValue
            self.keyboardChangeFrame(isAppear: notification.name != UIResponder.keyboardWillHideNotification, keyboardHeight: keyboardHeight, duration: duration ?? 0)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
