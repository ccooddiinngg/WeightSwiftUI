//
//  DataManager.swift
//  Weight
//
//  Created by Hanjun Kang on 6/9/21.
//

import Foundation

class DataManager: ObservableObject {
    enum Category: String, CaseIterable {
        case week = "Week", month = "Month", year = "Year", all = "All"
    }
}
