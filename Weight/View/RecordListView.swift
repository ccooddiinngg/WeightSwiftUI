//
//  RecordListView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/10/21.
//

import SwiftUI

struct RecordListView: View {
    @Environment(\.presentationMode) var presentation
    @FetchRequest(entity: WeightRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WeightRecord.timestamp, ascending: false)])
    var fetchResult: FetchedResults<WeightRecord>

    var body: some View {
        List {
            ForEach(fetchResult) {data in
                RecordRowView(data: data)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                })
            }
        })
    }
}
//
//struct RecordListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordListView()
//    }
//}
