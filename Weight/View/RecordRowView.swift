//
//  RecordRowView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/10/21.
//

import SwiftUI

struct RecordRowView: View {
    var data: WeightRecord

    var body: some View {
        ZStack(alignment: .leading) {
            Color.clear
            CardView(content: HStack {
                Image(systemName: dayAndMonth(data.timestamp).0)
                    .font(.system(size: 26, weight: .light, design: .rounded))
                    .foregroundColor(Color.accentColor)
                Text(dayAndMonth(data.timestamp).1)
                    .font(.system(size: 16, weight: .light, design: .rounded))
                    .foregroundColor(Color.gray)
//                Text("\(data.days)")
                Spacer()
                Text("\(String(format: "%.2f", data.weight))")
                Text("lb").foregroundColor(.gray)
                    .padding()
            }, color: Color.gray)
        }
        .frame(height: 60)
    }
}

//struct RecordRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordRowView(data: ).previewLayout(.sizeThatFits)
//    }
//}
