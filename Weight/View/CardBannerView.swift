//
//  CardBannerView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/11/21.
//

import SwiftUI

struct CardBannerView: View {
    var data: [WeightRecord]

    var body: some View {
        VStack {
            GeometryReader {proxy in
                Divider()
                buildCards(proxy: proxy)
                Divider()
            }
        }
        .frame(height: 100)
    }

    func buildCards(proxy: GeometryProxy) -> some View {

        return
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(data) {record in
                        buildCard(on: record, title: record.days == data.last?.days ? "Today":"x", proxy: proxy)
                    }
                }
            }
            .padding()

    }

    func buildCard(on record: WeightRecord?, title: String, proxy: GeometryProxy) -> some View {
        //        var weightInt: String = "-"
        //        var weightFloat: String = ".-"
        var weightString = "-.-"
        if let weight = record?.weight {
            weightString = String(format: "%.2f", weight)
            //            let indexOfDot = weightString.firstIndex(of: ".")
            //            weightInt = String(weightString.prefix(upTo: indexOfDot!))
            //            weightFloat = String(weightString.suffix(from: indexOfDot!))
        }

        return
            ZStack {
                RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1)
                VStack(alignment: .center) {
                    Text(weightString)
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    //                Text(weightFloat)
                    //                    .font(.subheadline)
                    //                    .fontWeight(.regular)
                    //                    .foregroundColor(.gray)
                    Spacer()
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(.gray)

                }.padding(10)

            .frame(width: proxy.size.width / 3.5)
        }
    }
}

//struct CardBannerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardBannerView()
//    }
//}
