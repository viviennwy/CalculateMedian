//
//  ViewController.swift
//  CalculateMedian
//
//  Created by vivien on 02/08/2022.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrayInput: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var medianLabel: UILabel!
    @IBOutlet weak var calcBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initLayout()
        
        viewModel.delegate = self
        
        // initialize custom keyboard
        let keyboardView = CustomKeyboardView(frame: CGRect(x: 0, y: 0, width: 0, height: viewModel.customKeyboardHeight))
        keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped

        // replace system keyboard with custom keyboard
        arrayInput.inputView = keyboardView
        
        addKeyboardNotificationCenter()
        addTapGestureDismissKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arrayInput.becomeFirstResponder()
    }
    
    override func keyboardChangeFrame(isAppear: Bool, keyboardHeight: CGFloat, duration: Double) {
        // keyboardChangeFrame notification
        UIView.animate(withDuration: duration) {
            self.bottomConstraint.constant = !isAppear ? 0 : keyboardHeight
        }
    }
    
    private func initLayout() {
        titleLabel.text = viewModel.titleText
        arrayInput.placeholder = viewModel.placeholderText
        errorLabel.textColor = UIColor.red
        hideError()
        calcBtn.titleLabel?.text = viewModel.calcBtnText
        clearBtn.titleLabel?.text = viewModel.clearBtnText
        meanLabel.text = viewModel.meanText
        medianLabel.text = viewModel.medianText
    }
    
    private func showError(msg: String) {
        errorLabel.text = msg
        errorLabel.isHidden = false
    }
    
    private func hideError() {
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
    
    // MARK:- Button actions from .storyboard file
    @IBAction func calculateAction(_ sender: Any) {
        hideError()
        viewModel.inputChecking(text: arrayInput.text ?? "")
    }
    
    @IBAction func clearAction(_ sender: Any) {
        hideError()
        arrayInput.text = ""
    }

}

// MARK:- ViewControllerDelegate
extension ViewController: ViewControllerDelegate {
    func validInput() {
        //vaild input and do calculate
        meanLabel.text = viewModel.meanText + String(viewModel.calcArr.mean)
        medianLabel.text = viewModel.medianText + String(viewModel.calcArr.median)
    }
    
    func invalidInput() {
        // invalid input and show error
        showError(msg: viewModel.errorMsg)
    }
}

// MARK:- KeyboardDelegate
extension ViewController: KeyboardDelegate {
    func keyWasTapped(character: String) {
        // numbers action
        arrayInput.insertText(character)
    }
    
    func backspace() {
        // backspace action
        arrayInput.deleteBackward()
    }
}
