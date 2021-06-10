//
//  ChartView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/8/21.
//

import SwiftUI

struct ChartView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: WeightRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WeightRecord.time, ascending: true)])
    var fetchResult: FetchedResults<WeightRecord>

    var mockData: [Float] = {
        var data = [Float]()
        for _ in 0..<365 {
            let r = Float.random(in: 120...160)
            data.append(r)
        }
        return data
    }()


    enum ChartData: String, CaseIterable {
        case seven = "7 Day", thirty = "30 Day", ninety = "90 Day", year = "1 Year"

        func range(_ results: [Float]) -> [Float] {
            results.prefix(self.barX).map{$0}
        }

        var chartX: Int {
            switch self {
            case .seven:
                return 7
            case .thirty:
                return 30
            case .ninety:
                return 30
            case .year:
                return 0
            }
        }

        var barX: Int {
            switch self {
            case .seven:
                return 7
            case .thirty:
                return 30
            case .ninety:
                return 90
            case .year:
                return 365
            }
        }

        var barWidth: CGFloat {
            switch self {
            case .seven:
                return 30
            case .thirty:
                return 10
            case .ninety:
                return 2
            case .year:
                return 1
            }
        }
    }

    var barHeight: Int {
        if let minValue = selection.range(mockData).min(), let maxValue = selection.range(mockData).max() {
            let height = (maxValue - minValue) / 0.8
            return Int(round(height))
        }
        return 300
    }

    var data: [Float] {
        if let minValue = selection.range(mockData).min(), let maxValue = selection.range(mockData).max() {
            var base = minValue - (maxValue - minValue) * 0.1
            base = max(base, 0)
            return selection.range(mockData).map {$0 - base}
        }
        return []
    }

    @State private var selection = ChartData.seven

    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selection, label: Text("Picker"), content: {
                    ForEach(ChartData.allCases, id:\.self) {category in
                        Text(category.rawValue).tag(category.rawValue)
                    }
                })
                .pickerStyle(SegmentedPickerStyle())

                BarChart(items: data, chartX: selection.chartX, chartY: 10, barX: selection.barX, barY: barHeight, barWidth: selection.barWidth, frameColor: Color.gray, chartColor: Color.black.opacity(0.6), barColor: .green)
                    .frame(height: 400)

                Spacer()
            }
            .padding()
            .navigationTitle("Progress")
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
