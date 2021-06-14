//
//  Weight.swift
//  Weight
//
//  Created by Hanjun Kang on 6/13/21.
//

import Foundation

class Weight: Identifiable {
    var id: UUID
    var days: Int
    var date: Date
    var weight: Float
    var useMetric: Bool
    var saved: Bool

    init(id: UUID, days: Int, date: Date, weight: Float, useMetric: Bool, saved: Bool) {
        self.id = id
        self.days = days
        self.date = date
        self.weight = weight
        self.useMetric = useMetric
        self.saved = saved
    }

}
