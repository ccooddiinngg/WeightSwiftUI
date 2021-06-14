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

    func getDay(_ from: Date) -> Int? {
        dateComponents([.day], from: from).day
    }

    func getWeekday(_ from: Date) ->  String? {
        let weekday = dateComponents([.weekday], from: from).weekday
        switch weekday {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return nil
        }
    }
}
