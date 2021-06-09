//
//  WeekChartView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/8/21.
//

import SwiftUI

struct WeekChartView: View {
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10).frame(width: 2, height: 150).foregroundColor(.gray)
                Circle().fill(Color.green).frame(width: 10, height: 10).offset(x: 0, y: -100 + 5)
            }.padding(.bottom, 8)


        }
    }
}


struct WeekChartView_Previews: PreviewProvider {
    static var previews: some View {
        WeekChartView()
    }
}
