//
//  Constant.swift
//  Weight
//
//  Created by Hanjun Kang on 6/12/21.
//

import Foundation

var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

let startDaySince20010101 = Date(timeIntervalSinceReferenceDate: 0)

func dayAndMonth(_ date: Date?) -> (String, String) {
    if let date = date {
        let components = Calendar.current.dateComponents([.day, .month], from: date)
        if let dayInt = components.day , let monthInt = components.month {
            let monthString = Calendar.current.monthSymbols[monthInt]
            return ("\(dayInt).circle.fill", monthString)
        }
    }
    return ("questionmark.circle.fill", " ")
}
