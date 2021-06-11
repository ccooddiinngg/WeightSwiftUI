//
//  ChartView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/8/21.
//

import SwiftUI

enum ChartData: String, CaseIterable {
    case seven = "7 Day", thirty = "30 Day", ninety = "90 Day", year = "1 Year"

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

struct ChartView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: WeightRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WeightRecord.timestamp, ascending: true)])
    var fetchResult: FetchedResults<WeightRecord>

//    var mockData: [Float] = {
//        var data = [Float]()
//        for _ in 0..<500 {
//            let r = Float.random(in: 120...160)
//            data.append(r)
//        }
//        return data
//    }()

    var data: [Float] {
        let today = Calendar.current.numberOfDaysBetween(Date(timeIntervalSinceReferenceDate: 0), and: Date())
        var startDay = today - selection.barX + 1
        if let firstRecord = fetchResult.first?.days {
            startDay = max(startDay, Int(firstRecord))
        }

        return (startDay...today).map {day in
            if let found = fetchResult.first(where: {$0.days == day}) {
                return found.weight
            }
            return 0
        }
    }

    @State private var selection = ChartData.seven

    var body: some View {
        NavigationView {
            ZStack {
                Color.clear.ignoresSafeArea()
                VStack {
                    Picker(selection: $selection, label: Text("Picker"), content: {
                        ForEach(ChartData.allCases, id:\.self) {category in
                            Text(category.rawValue).tag(category.rawValue)
                        }
                    })
                    .pickerStyle(SegmentedPickerStyle())

                    BarChart(items: data, chartX: selection.chartX, chartY: 10, barX: selection.barX, barLow: 100,barHigh: 200, barWidth: selection.barWidth, frameColor: Color.gray, chartColor: Color.black.opacity(0.6), barColor: .green)
                        .frame(height: 400)

                    Spacer()
                }
                .padding()
            }.navigationTitle("Progress")
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
