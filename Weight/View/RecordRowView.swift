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
                Image(systemName: dayAndMonth(data.timestamp).0).font(.largeTitle).foregroundColor(Color.accentColor)
                Text(dayAndMonth(data.timestamp).1)
//                Text("\(data.days)")
                Spacer()
                Text("\(String(format: "%.2f", data.weight))")
                Text("lb").foregroundColor(.gray)
                    .padding()
            }, color: Color.accentColor)
        }
        .frame(height: 60)
    }
}

//struct RecordRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordRowView(data: ).previewLayout(.sizeThatFits)
//    }
//}
