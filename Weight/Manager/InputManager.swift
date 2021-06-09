//
//  InputManager.swift
//  Weight
//
//  Created by Hanjun Kang on 6/8/21.
//

import SwiftUI

class InputManager: ObservableObject {
    @Published private(set) var warning = " "

    @Published private(set) var weight = "0"

    let textArray = ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "✗"]

    private let digitLimit = 4
    private let decimalLimit = 2

    private var useMetric: Bool

    init(useMetric: Bool = false) {
        self.useMetric = useMetric
    }

    let dateString: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }()

    let feedback = UIImpactFeedbackGenerator(style: .medium)

    func handleInput(_ key: String) {
        if key == "✔︎" {
            feedback.impactOccurred()

            if weight.last == "." {
                weight.append("0")
            }

            if let weightDouble = Double(weight) {
                submit(weightDouble)
                weight = "0"
                warning = " "
            }
            return
        }

        if key == "✗" {
            feedback.impactOccurred()
            weight = "0"
            warning = " "
            return
        }

        if key == "."  {
            if !weight.contains(".") {
                weight.append(".")
            }
            warning = " "
            return
        }

        if weight.first == "0" && !weight.contains(".") {
            weight = key
        }else if weight.contains(".") && weight.suffix(from: weight.firstIndex(of: ".")!).count >= decimalLimit + 1 {
            warning = "\(decimalLimit) decimal place accuracy only."
        }else if (!weight.contains(".") && weight.count >= digitLimit)  || (weight.contains(".") && weight.prefix(while: {$0 != "."}).count > digitLimit) {
            warning = "\(digitLimit)-digit number only."
        }else {
            weight.append(key)
        }


    }

    func submit(_ weight: Double) {
        print(weight)
    }

}
