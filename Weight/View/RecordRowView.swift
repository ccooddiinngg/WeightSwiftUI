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
            CardView(content: Text("Jun 14 2021 135.45 lb"), color: Color.green)
        }
        .frame(height: 80)
    }
}

struct RecordRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecordRowView().previewLayout(.sizeThatFits)
    }
}
