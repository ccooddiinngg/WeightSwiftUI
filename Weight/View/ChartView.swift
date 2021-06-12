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

//    var mockData: [Float] = {
//        var data = [Float]()
//        for _ in 0..<500 {
//            let r = Float.random(in: 120...160)
//            data.append(r)
//        }
//        return data
//    }()

    var data: [WeightRecord] {
        PersistenceController.shared.fetchLastRecords(within: selection.barX)
    }

    var weightData: [Float] {
        data.map {$0.weight}
    }

    @State private var selection = ChartData.seven

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Picker(selection: $selection, label: Text("Picker"), content: {
                        ForEach(ChartData.allCases, id:\.self) {category in
                            Text(category.rawValue).tag(category.rawValue)
                        }
                    })
                    .pickerStyle(SegmentedPickerStyle())

                    CardBannerView(data: data)

                    BarChart(items: weightData, chartX: selection.chartX, chartY: 10, barX: selection.barX, barLow: 120,barHigh: 180, barWidth: selection.barWidth, frameColor: Color.gray, chartColor: Color.black.opacity(0.6), barColor: .green)
                        .frame(height: 400)

                }
                .padding()
            }
            .navigationTitle("Progress")
        }


    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
