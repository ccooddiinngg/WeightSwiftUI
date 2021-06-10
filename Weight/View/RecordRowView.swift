//
//  RecordRowView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/10/21.
//

import SwiftUI

struct RecordRowView: View {


    var body: some View {
        ZStack(alignment: .leading) {
            Color.clear
            CardView(content: HStack {
                Image(systemName: "\(27).circle.fill").font(.largeTitle).foregroundColor(Color.red)
                Text("Jun 2021")
                Spacer()
                Text(" 135.45 ")
                Text("lb").foregroundColor(.gray)
                    .padding()
            }, color: Color.green)
        }
        .frame(height: 60)
    }
}

struct RecordRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecordRowView().previewLayout(.sizeThatFits)
    }
}
