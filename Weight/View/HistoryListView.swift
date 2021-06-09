//
//  HistoryListView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/8/21.
//

import SwiftUI

struct HistoryListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(1..<10, id:\.self) {i in
                    Text("\(i)")
                }
                
            }
        }
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
    }
}
