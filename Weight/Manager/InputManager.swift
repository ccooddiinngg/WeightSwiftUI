//
//  InputManager.swift
//  Weight
//
//  Created by Hanjun Kang on 6/8/21.
//

import SwiftUI

class InputManager: ObservableObject {
    @Published var warning = " "

    @Published var weight = "0"

    let textArray = ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "C"]

    let digitLimit = 4
    let decimalLimit = 2

    let dateString: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }()

    let feedback = UIImpactFeedbackGenerator(style: .medium)

    func setWarning(_ warning: String) {
        self.warning = warning
    }


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

        if key == "C" {
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
            setWarning("\(decimalLimit) decimal place accuracy at most.")
        }else if (!weight.contains(".") && weight.count >= digitLimit)  || (weight.contains(".") && weight.prefix(while: {$0 != "."}).count > digitLimit) {
            setWarning("\(digitLimit)-digit number at most.")
        }else {
            weight.append(key)
        }


    }

    func submit(_ weight: Double) {
        print(weight)
    }

}
