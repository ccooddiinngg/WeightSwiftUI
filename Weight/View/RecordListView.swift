//
//  RecordListView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/10/21.
//

import SwiftUI

struct RecordListView: View {
    @FetchRequest(entity: WeightRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WeightRecord.timestamp, ascending: false)])
    var fetchResult: FetchedResults<WeightRecord>

    var body: some View {
        List {
            ForEach(fetchResult) {data in
                RecordRowView(data: data)
            }
        }
    }
}
//
//struct RecordListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordListView()
//    }
//}
