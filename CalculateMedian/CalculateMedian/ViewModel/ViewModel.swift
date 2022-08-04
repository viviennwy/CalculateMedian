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
        // allow number and comma. But on start and end it does not allow comma.
//        let numberAndComma = "^\\d*\\,?\\d*$"
        let numberAndComma = "\\d+,?\\d+\\$?"
        //This regular expression is used to validate only comma separated numbers.
//        let numberAndComma = "^([0-9]*)+(,[0-9]+)+$"
//        let numberAndComma = "^([0-9][,]?)*([0-9]*)$"
//        let numberAndComma = "^\\d*\\,?\\d*$"
        return inputText.isMatching(regex: numberAndComma)
    }
    
    func inputChecking(text: String) {
        errorMsg = ""
        if text.isEmpty {
            // empty
            errorMsg = InputError.emptyError.rawValue
            delegate?.invalidInput()
        } else if text.prefix(1) == "," || text.suffix(1) == "," {
            // start with or end with ','
            errorMsg = InputError.invalidError.rawValue
            delegate?.invalidInput()
        } else if text.isInt || isInputValid(inputText: text) {
            // valid input set of numbers
            let str = text.replacingOccurrences(of: " ", with: "")
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
