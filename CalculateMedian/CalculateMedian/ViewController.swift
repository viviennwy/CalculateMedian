//
//  ViewController.swift
//  CalculateMedian
//
//  Created by vivien on 02/08/2022.
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

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Test
        let input = [1, 4, 5, 6, 7, 12, 14, 18, 19, 20, 22, 24]
//        let input = [1, 2, 3, 4, 5, 6, 7, 8, 9]
//        let input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//        let input = [1, 6, 7, 4, 2, 10]

        print("mean", input.mean)
        print("median", input.median)
    }


}

