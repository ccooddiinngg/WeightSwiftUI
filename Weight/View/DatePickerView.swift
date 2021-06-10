//
//  DatePickerView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/9/21.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date

    var body: some View {
        ZStack {
            DatePicker("", selection: $date, displayedComponents: [.date]).datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}

