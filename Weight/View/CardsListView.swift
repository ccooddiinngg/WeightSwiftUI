//
//  CardsListView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/14/21.
//

import SwiftUI

struct CardsListView: View {
    var weightData: [Weight]
    @Binding var selection: ChartData
    @Binding var selected: Weight
    @Binding var showSheet: Bool

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Image(systemName: "decrease.quotelevel")
                        .rotation3DEffect(Angle.degrees(180),axis: (x: 0.0, y: 1.0, z: 0.0))
                        .font(.system(size: 40, weight: .regular, design: .rounded))
                        .foregroundColor(.gray)
                        .id(-selection.barX)

                    ForEach(0..<weightData.count) { index in
                        dayCard(at: index).id(index)
                    }

                    Image(systemName: "decrease.quotelevel")
                        .font(.system(size: 40, weight: .regular, design: .rounded))
                        .foregroundColor(.gray)
                        .id(selection.barX)
                }
                .padding(5)
                .onAppear {
                    proxy.scrollTo(selection.barX, anchor: .trailing)
                }
            }
        }
    }

    func dayCard(at index: Int) -> some View {
        let weight = weightData[index]
        let weekdayText = Calendar.current.getWeekday(weight.date) ?? ""
        let dayText = "\(Calendar.current.getDay(weight.date) ?? 0)"
        let weightText = weight.saved ? String(format: "%.2f",weightData[index].weight) : "..."
        let systemName = weight.saved ? "pencil.circle":"plus.circle"
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
                Image(systemName: systemName)
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

