//
//  ViewModel.swift
//  CalculateMedian
//
//  Created by vivien on 04/08/2022.
//

import Foundation

protocol ViewControllerDelegate: NSObjectProtocol {
    func validInput()
    func invalidInput()
}

enum InputError: String {
    case emptyError = "Please enter a set of numbers"
    case invalidError = "Invalid input format. e.g 1,2,3"
    case notError = ""
}

class ViewModel {
    weak var delegate: ViewControllerDelegate?
    var calcArr: [Int] = []
    var errorMsg = InputError.notError.rawValue
    
    let titleText = "Please enter a set of numbers"
    let placeholderText = "1,2,3,4"
    let calcBtnText = "Calculate"
    let clearBtnText = "Clear"
    let meanText = "Mean: "
    let medianText = "Median: "
    let customKeyboardHeight = 300
    
    private func isInputValid(inputText: String) -> Bool {
        // allow number and comma.
        let numberAndComma = "^([0-9]*)+(,[0-9]+)+$"
        return inputText.isMatching(regex: numberAndComma)
    }
    
    func inputChecking(text: String) {
        errorMsg = ""
        let str = text.replacingOccurrences(of: " ", with: "")
        if str.isEmpty {
            // empty
            errorMsg = InputError.emptyError.rawValue
            delegate?.invalidInput()
        } else if str.prefix(1) == "," || str.suffix(1) == "," {
            // start with or end with ','
            errorMsg = InputError.invalidError.rawValue
            delegate?.invalidInput()
        } else if str.isInt || isInputValid(inputText: str) {
            // valid input set of numbers
            let arr = str.split(separator: ",")
            let intArray = arr.compactMap { Int($0) }
            
            calcArr = intArray
            delegate?.validInput()
        } else {
            // invalid input set of numbers
            errorMsg = InputError.invalidError.rawValue
            delegate?.invalidInput()
        }
    }
}
