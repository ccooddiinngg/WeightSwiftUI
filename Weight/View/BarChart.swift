//
//  BarChart.swift
//  Weight
//
//  Created by Hanjun Kang on 6/9/21.
//

import SwiftUI

struct BarChart: View {
    var items: [Float]
    var chartX: Int
    var chartY: Int
    var barX: Int
    var barLow: Float
    var barHigh: Float
    var barWidth: CGFloat

    var frameColor: Color
    var chartColor: Color
    var barColor: Color

    var body: some View {
        ZStack {
            ChartFrame().stroke(frameColor)
            Chart( segmentX: chartX, segmentY: chartY).stroke(chartColor, style: .init(lineWidth: 1, dash: [1, 3]))
            GeometryReader {proxy in
                buildBar(proxy: proxy)
            }
            GeometryReader {proxy in
                buildCoordinate(proxy: proxy)
            }
        }
        .animation(.easeIn)
        .clipped()
    }

    func buildBar(proxy: GeometryProxy) -> some View {
        ForEach(0..<items.count, id:\.self) {i in
            Color.green
                .frame(width: barWidth, height: max(0, CGFloat(400 * (items[i] - barLow) / (barHigh - barLow))))
                .offset(x: CGFloat(i + 1) * proxy.frame(in: .local).maxX / (CGFloat(barX) + 1.0) - (barWidth / 2), y: proxy.frame(in: .local).maxY - CGFloat(400 * (items[i] - barLow) / (barHigh - barLow)))
        }
    }

    func buildCoordinate(proxy: GeometryProxy) -> some View {
        ForEach(1..<chartY+1, id:\.self) {i in
            Text("\(Int(((barHigh-barLow) / Float(chartY) * Float(i)) + barLow))")
                .font(.footnote)
                .foregroundColor(.gray)
                .offset(x: 0, y: proxy.frame(in: .local).maxY - proxy.frame(in: .local).maxY / CGFloat(chartY) * CGFloat(i))
        }
    }
}

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

struct Chart: Shape {
    var segmentX: Int
    var segmentY: Int

    func path(in rect: CGRect) -> Path {
        var p = Path()

        for i in 1..<segmentY+1 {
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

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(items: [12,34,23,12,35,46,90], chartX: 7, chartY: 5,barX: 7,barLow: 0,barHigh: 100, barWidth: 20, frameColor: Color.blue,chartColor: .black.opacity(0.4), barColor: Color.blue).padding().previewLayout(.sizeThatFits)
    }
}
