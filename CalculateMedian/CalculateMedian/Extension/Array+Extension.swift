//
//  Array+Extension.swift
//  CalculateMedian
//
//  Created by vivien on 03/08/2022.
//

import Foundation

extension Array where Element == Int {
    
    var mean: Double {
        // Calculate sum of items with reduce function
        let sum = self.reduce(0, { a, b in
            return a + b
        })
        
        let mean = Double(sum) / Double(self.count)
        return Double(mean)
    }
    
    var median: Double {
        // Array should be sorted
        let sorted = self.sorted()
        let length = self.count
        
        // handle when count of items is even
        if (length % 2 == 0) {
            return (Double(sorted[length / 2 - 1]) + Double(sorted[length / 2])) / 2.0
        }
        
        // handle when count of items is odd
        return Double(sorted[length / 2])
    }
}
