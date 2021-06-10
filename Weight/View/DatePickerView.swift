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
                HStack{}.frame(height: 100)
                DatePicker("", selection: $date, displayedComponents: [.date]).datePickerStyle(GraphicalDatePickerStyle())
                    .background(Color("_LightGray"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                    .shadow(radius: 1)
                Spacer()
            }
        }.ignoresSafeArea()
    }
}



struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(date: .constant(Date()))
    }
}
