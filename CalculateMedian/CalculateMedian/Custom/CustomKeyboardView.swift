//
//  CustomKeyboardView.swift
//  CalculateMedian
//
//  Created by vivien on 03/08/2022.
//

import UIKit

// The view controller will adopt this protocol (delegate)
// and thus must contain the keyWasTapped method
protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
    func backspace()
}

class CustomKeyboardView: UIView {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    // This variable will be set as the view controller so that the keyboard can send messages to the view controller.
    weak var delegate: KeyboardDelegate?

    // MARK:- keyboard initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }

    func initializeSubviews() {
        let xibFileName = "CustomKeyboardView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }

    // MARK:- Button actions from .xib file
    @IBAction func keyTapped(sender: UIButton) {
        // When a button is tapped, send that information to the
        // delegate (ie, the view controller)
        let str = sender.titleLabel?.text?.replacingOccurrences(of: " ", with: "")
        self.delegate?.keyWasTapped(character: str ?? "") // could alternatively send a tag value
    }
    
    @IBAction func backspace(sender: UIButton) {
        self.delegate?.backspace()
    }
}
