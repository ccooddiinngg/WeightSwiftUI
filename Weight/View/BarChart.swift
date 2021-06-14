//
//  BarChart.swift
//  Weight
//
//  Created by Hanjun Kang on 6/9/21.
//

import SwiftUI

struct BarChart: View {
    var weights: [Weight]
    var chartX: CGFloat
    var chartY: CGFloat
    var barX: CGFloat
    var barLow: CGFloat
    var barHigh: CGFloat
    var barWidth: CGFloat

    var frameColor: Color
    var chartColor: Color
    var barColor: Color

    var items: [Float] {
        weights.map { $0.weight}
    }
    var weekdays: [String] {
        weights.map { (Calendar.current.getWeekday($0.date) ?? "?")}
    }
    var body: some View {
        ZStack {
            GeometryReader {proxy in
                ChartFrame().stroke(frameColor)
                ChartHorizontalLine( segmentX: chartX, segmentY: chartY).stroke(chartColor, style: .init(lineWidth: 1, dash: [1, 3]))
                buildBars(proxy: proxy)
                buildCoordinate(proxy: proxy)
                buildItemsTitle(proxy: proxy)
            }
        }
        .clipped()
    }

    @ViewBuilder
    func buildBars(proxy: GeometryProxy) -> some View {
        ForEach(0..<items.count, id:\.self) {i in
            buildBar(proxy: proxy, i: i)
        }
    }

    func buildBar(proxy: GeometryProxy, i: Int) -> some View {
        let x = (CGFloat(i) + 1) * proxy.size.width / (barX + 1.0) - (barWidth / 2)
        let y = proxy.size.height - proxy.size.height * (CGFloat(items[i]) - barLow) / (barHigh - barLow)
        return
            Capsule().fill(Color.green)
                .frame(width: barWidth, height: max(0, proxy.size.height * (CGFloat(items[i]) - barLow) / (barHigh - barLow)))
                .offset(x: x, y: y)

    }

    func buildCoordinate(proxy: GeometryProxy) -> some View {
        ForEach(1..<Int(chartY)+1, id:\.self) {i in
            Text(coordinate(i: i))
                .font(.footnote)
                .foregroundColor(.gray)
                .offset(x: 0, y: proxy.size.height - proxy.size.height / chartY * CGFloat(i))
        }
    }

    func coordinate(i: Int) -> String {
        let value = (barHigh-barLow) / chartY * CGFloat(i) + barLow
        let valueString = String(format: "%.1f", value)
        return valueString
    }

    func buildItemsTitle(proxy: GeometryProxy) -> some View {
        ForEach(0..<items.count, id:\.self) {i in
            ZStack {
                Text("\(String(weekdays[i].first ?? "?"))")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
            }
            .offset(x: (CGFloat(i) + 1) * proxy.size.width / (barX + 1.0) - 10, y: proxy.size.height - barWidth)
        }
    }
}

//Outer Line
struct ChartFrame: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addLines([
            CGPoint(x: 0, y: 0),
            CGPoint(x: rect.maxX, y: 0),
            CGPoint(x: rect.maxX, y: rect.maxY),
            CGPoint(x: 0, y: rect.maxY),
            CGPoint(x: 0, y: 0)
        ])
        return p
    }
}

//Horizontal Line
struct ChartHorizontalLine: Shape {
    var segmentX: CGFloat
    var segmentY: CGFloat

    func path(in rect: CGRect) -> Path {
        var p = Path()

        for i in 1..<Int(segmentY)+1 {
            p.move(to: CGPoint(x: 0, y: CGFloat(i) * rect.maxY / CGFloat(segmentY)))
            p.addLine(to: CGPoint(x: rect.maxX, y: CGFloat(i) * rect.maxY / CGFloat(segmentY)))
        }

//        for i in 1..<segmentX+1{
//            p.move(to: CGPoint(x: CGFloat(i) * rect.maxX / CGFloat(segmentX+1), y: rect.maxY))
//            p.addLine(to: CGPoint(x: CGFloat(i) * rect.maxX / CGFloat(segmentX+1), y: 0))
//        }

        return p
    }
}

//struct Bars: Shape {
//    var items: [Float]
//    var posX: Int
//
//    var low: Float
//    var high: Float
//
//    var barWidth: CGFloat
//
//    func path(in rect: CGRect) -> Path {
//        var p = Path()
//
//        for (index, item) in items.enumerated() {
//            let x = CGFloat(index + 1) * rect.maxX / CGFloat(posX+1)
//            var y = rect.maxY - rect.maxY * CGFloat(item - low) / CGFloat(high - low)
//            y = min(y, rect.maxY)
//
//            p.addLines([
//                CGPoint(x: x - barWidth / 2, y: rect.maxY),
//                CGPoint(x: x - barWidth / 2, y: y),
//                CGPoint(x: x + barWidth / 2, y: y),
//                CGPoint(x: x + barWidth / 2, y: rect.maxY),
//                CGPoint(x: x - barWidth / 2, y: rect.maxY),
//            ])
//        }
//
//        return p
//    }
//}

enum ChartData: String, CaseIterable {
    case seven = "7 Day", thirty = "30 Day", ninety = "90 Day", year = "1 Year"

    var chartX: CGFloat {
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

    var barX: CGFloat {
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

