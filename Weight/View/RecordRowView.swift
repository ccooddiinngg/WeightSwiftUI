//
//  RecordRowView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/10/21.
//

import SwiftUI

struct RecordRowView: View {
    var data: WeightRecord
    
    var dayAndMonth: (String, String) {
        if let date = data.timestamp {
            let components = Calendar.current.dateComponents([.day, .month], from: date)
            if let dayInt = components.day , let monthInt = components.month {
                let monthString = Calendar.current.monthSymbols[monthInt]
                return ("\(dayInt).circle.fill", monthString)
            }
        }
        return ("questionmark.circle.fill", " ")
    }

    var body: some View {

        ZStack(alignment: .leading) {
            Color.clear
            CardView(content: HStack {
                Image(systemName: dayAndMonth.0).font(.largeTitle).foregroundColor(Color.green)
                Text(dayAndMonth.1)
                Text("\(data.days)")
                Spacer()
                Text("\(String(format: "%.2f", data.weight))")
                Text("lb").foregroundColor(.gray)
                    .padding()
            }, color: Color.green)
        }
        .frame(height: 60)
    }
}

//struct RecordRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordRowView(data: ).previewLayout(.sizeThatFits)
//    }
//}
