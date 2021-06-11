//
//  Calendar+numberOfDaysBetween.swift
//  Weight
//
//  Created by Hanjun Kang on 6/10/21.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ from: Date , and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day!
    }
}
