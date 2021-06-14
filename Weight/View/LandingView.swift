//
//  LandingView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/12/21.
//

import SwiftUI

class BarRange: ObservableObject {
    @Published var low: Float = 140
    @Published var high: Float = 150

    func setBarRange(_ weight: Float) {
        if weight > high {
            high = weight / 0.99
        }
        if weight <= low {
            low = weight * 0.99
        }
    }
}

struct LandingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WeightRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WeightRecord.timestamp, ascending: false)])
    var fetchResults: FetchedResults<WeightRecord>

    @StateObject var barRange = BarRange()

    @State private var selection = ChartData.seven
    @State private var showSheet = false
    @State private var selected = Weight(id: UUID(), days: 0, date: Date(), weight: 0, useMetric: false, saved: false)
    @State private var navigation : Int? = 0


    func initWeightData(results: FetchedResults<WeightRecord>, within days: Int) -> [Weight] {
        let today = Calendar.current.numberOfDaysBetween(startDaySince20010101, and: Date())
        let from = today - days + 1
        let range = from...today
        return range.map {days in
            if let record = results.first(where: {$0.days == days}) {
                barRange.setBarRange(record.weight)
                let weight = Weight(id: record.id!, days: Int(record.days), date: record.timestamp!, weight: record.weight, useMetric: record.useMetric, saved: true)
                return weight
            }
            var dateComponents = DateComponents()
            dateComponents.day = days
            let date = Calendar.current.date(byAdding: dateComponents, to: startDaySince20010101)
            let weight = Weight(id: UUID(), days: days, date: date!, weight: 0, useMetric: false, saved: false)
            return weight
        }
    }

    var weightData: [Weight] {
        initWeightData(results: fetchResults, within: Int(selection.barX))
    }

    let bg = LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)

    var body: some View {

        ZStack {
            Color(.systemGray6).ignoresSafeArea(.all, edges: .bottom)
            VStack {
                Divider()
                CardsListView(weightData: weightData, selection: $selection, selected: $selected, showSheet: $showSheet)

                BarChart(weights: weightData, chartX: selection.chartX, chartY: 10, barX: selection.barX, barLow: CGFloat(barRange.low),barHigh: CGFloat(barRange.high), barWidth: selection.barWidth, frameColor: Color.gray, chartColor: Color.black.opacity(0.6), barColor: .green)

                NavigationLink(
                    destination: RecordListView(),
                    tag: 1,
                    selection: $navigation,
                    label: {EmptyView()})
            }
            .sheet(isPresented: $showSheet) {
                InputView(selected: $selected).environment(\.managedObjectContext, viewContext)
            }
        }

        .navigationTitle("Daca")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("\(Calendar.current.getWeekday(Date()) ?? "") \(Calendar.current.getDay(Date()) ?? 0)").foregroundColor(.gray)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    navigation = 1
                }, label: {
                    Image(systemName: "list.bullet")
                })
            }
        }
        
    }

    func addButton() -> some View {
        Button(action: {
            navigation = 1
        }, label: {
            ZStack {
                Circle().fill(Color.accentColor).shadow(radius: 3)
                Image(systemName: "plus")
                    .font(.system(size: 40, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
            }
            .frame(width: 50, height: 50)
        })
    }


    

}

//struct LandingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LandingView()
//    }
//}
