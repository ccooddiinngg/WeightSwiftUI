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
            Color("_Charcoal")
            VStack {
                DatePicker("", selection: $date, displayedComponents: [.date]).datePickerStyle(GraphicalDatePickerStyle())
                    .background(Color("_LightGray"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                    .shadow(radius: 1)
            }
        }.ignoresSafeArea()
    }
}



struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(date: .constant(Date()))
    }
}
