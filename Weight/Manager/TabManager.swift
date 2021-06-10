//
//  TabManager.swift
//  Weight
//
//  Created by Hanjun Kang on 6/9/21.
//

import Foundation
import Combine

final class TabManager: ObservableObject {
    let functionTab: Int
    var functionTabSelected: Bool = false
    let objectWillChange = PassthroughSubject<TabManager, Never>()

    var tabSelected: Int {
        didSet {
            if tabSelected == functionTab {
                tabSelected = oldValue
                functionTabSelected = true
            }
            objectWillChange.send(self)
        }
    }

    init(tabSelected: Int = 0, functionTab: Int) {
        self.tabSelected = tabSelected
        self.functionTab = functionTab
    }
}
