//
//  String+Extension.swift
//  CalculateMedian
//
//  Created by vivien on 04/08/2022.
//

import Foundation


extension String {

    var isInt: Bool {
        return Int(self) != nil
    }
    
    func isMatching(regex regexString: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regexString, options: .caseInsensitive)
            let option = NSRegularExpression.MatchingOptions(rawValue: 0)
            let range = NSRange(location: 0, length: count)
            return regex.firstMatch(in: self, options: option, range: range) != nil
        } catch {
            debugPrint("String: \(self) is not matching regex: \(regexString)")
            return false
        }
    }
}
