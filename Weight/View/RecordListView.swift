//
//  RecordListView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/10/21.
//

import SwiftUI

struct RecordListView: View {
    var body: some View {
        List {
            ForEach(0..<10, id:\.self) {i in
                RecordRowView()
            }
        }
    }
}

struct RecordListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordListView()
    }
}
