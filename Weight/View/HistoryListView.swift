//
//  ChartView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/8/21.
//

import SwiftUI

struct ChartView: View {
    @StateObject var dataManager = DataManager()
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: WeightRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WeightRecord.time, ascending: true)])
    var fetchResult: FetchedResults<WeightRecord>

    var weekResults: [Float] {
        [152.23, 154.25, 156, 153.02, 150, 147, 149.98]
    }

    let week = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var barHeight: Int {
        if let minValue = weekResults.min(), let maxValue = weekResults.max() {
            let height = (maxValue - minValue) / 0.8
            return Int(round(height))
        }
        return 300
    }

    var results: [Float] {
        if let minValue = weekResults.min(), let maxValue = weekResults.max() {
            var base = minValue - (maxValue - minValue) * 0.1
            base = max(base, 0)
            return weekResults.map {$0 - base}
        }
        return []
    }

    @State private var selection = DataManager.Category.week

    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("Picker"), content: {
                ForEach(DataManager.Category.allCases, id:\.self) {category in
                    Text(category.rawValue).tag(category.rawValue)
                }
            })
            .pickerStyle(SegmentedPickerStyle())

            BarChart(items: results, chartX: 8, chartY: 10, barX: 8, barY: barHeight, barWidth: 30, frameColor: Color.blue, chartColor: Color.black.opacity(0.6), barColor: .green)
                .frame(height: 400)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
