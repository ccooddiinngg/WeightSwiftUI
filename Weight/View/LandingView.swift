//
//  LandingView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/12/21.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: WeightRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \WeightRecord.timestamp, ascending: false)])
    var fetchResults: FetchedResults<WeightRecord>

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
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            Image(systemName: "decrease.quotelevel").rotation3DEffect(
                                Angle.degrees(180),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            ).font(.system(size: 40, weight: .regular, design: .rounded)).foregroundColor(.gray).id(-selection.barX)
                            ForEach(0..<weightData.count) { index in
                                dayCard(at: index).id(index)
                            }
                            Image(systemName: "decrease.quotelevel").font(.system(size: 40, weight: .regular, design: .rounded)).foregroundColor(.gray).id(selection.barX)
                        }
                        .padding(5)
                        .onAppear {
                            proxy.scrollTo(selection.barX, anchor: .trailing)
                        }
                    }
                }

                BarChart(weights: weightData, chartX: selection.chartX, chartY: 10, barX: selection.barX, barLow: 140,barHigh: 160, barWidth: selection.barWidth, frameColor: Color.gray, chartColor: Color.black.opacity(0.6), barColor: .green)

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


    func dayCard(at index: Int) -> some View {
        let weight = weightData[index]
        let weekdayText = Calendar.current.getWeekday(weight.date) ?? ""
        let dayText = "\(Calendar.current.getDay(weight.date) ?? 0)"
        let weightText = weight.saved ? String(format: "%.2f",weightData[index].weight) : "..."
        return VStack {
            HStack {
                Text(weekdayText)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(Color.gray)
                Text(dayText)
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(Color.blue)
            }.padding()


            Text(weightText)
                .font(.system(size: 24, weight: .regular, design: .default))
                .foregroundColor(Color.primary)
                .padding(5)

            Button(action: {
                selected = weight
                showSheet.toggle()
            }, label: {
                Image(systemName: "eject.circle")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .padding(5)
            })

        }
        .padding(5)
        .frame(width: 120, height: 160)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray5)))

    }

}

//struct LandingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LandingView()
//    }
//}
