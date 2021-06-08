//
//  ScaleView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/5/21.
//

import SwiftUI

struct ScaleView: View {
    @Binding var weight: Double
    @Binding var useMetric: Bool
    @Binding var hideBottomBar: Bool

    var onSubmit: (Double)->()

    let date: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: Date())
    }()

    var button = ["7", "8", "9", "←", "4", "5", "6", "lb","1", "2", "3", "kg", "0", "00", ".", "✔︎"]

    @State private var weightString : String = "0"

    var body: some View {
        GeometryReader {proxy in
            ZStack(alignment: .center) {
                VStack {
                    Text(date).font(.headline).foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))).padding()

                    HStack(alignment: .bottom) {
                        Spacer()
                        Text("\(weightString)")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        Text("lb")
                            .font(.title3)
                            .foregroundColor(.blue).padding(2)
                    }.padding(.horizontal, 80)

                    let columns = Array(repeating: GridItem(.fixed(80)), count: 4)
                    LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                        ForEach(button, id:\.self) {key in
                            ZStack {
                                Color.gray
                                if  ["←", "lb","kg", "✔︎"].contains(key) {
                                    Color(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))
                                }
                                Button(action: {
                                    onClick(key)
                                }, label: {
                                    Text(key).font(.largeTitle).fontWeight(.medium).foregroundColor(.white).padding()
                                })
                            }.frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipShape(Circle())
                        }
                    }

                }
            }.frame(width: proxy.size.width, height: proxy.size.width * 1.6, alignment: .center)
        }
    }

    func onClick(_ key: String) {
        if key == "✔︎" {
            if weightString.count == 0 {
                weightString = "0"
            }else if weightString.last == "." {
                weightString.append("0")
            }
            onSubmit(Double(weightString)!)
            return
        }

        if key == "lb" {
            useMetric = false
            return
        }
        if key == "kg" {
            useMetric = true
            return
        }

        if key == "←" {
            guard weightString.count > 1 else {
                weightString = "0"
                return
            }
            if weightString.last == "." {
                weightString.removeLast()
            }
            weightString.removeLast()
            if weightString.count == 0 {
                weightString = "0"
            }
            return
        }

        guard weightString.count < 7 else {
            return
        }

        if key == "." {
            guard !weightString.contains(".") else {
                return
            }
            weightString.append(".")
            return
        }

        if weightString.first == "0" && !weightString.contains(".") && key != "00"{
            weightString = key
        }else if weightString.first == "0" && !weightString.contains(".") && key == "00" {

        }else if weightString.count == 6 && key == "00"{
            weightString.append("0")
        }else {
            weightString.append(key)
        }
    }


}


struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleView(weight: .constant(150), useMetric: .constant(false), hideBottomBar: .constant(false), onSubmit: {_ in}).previewLayout(.sizeThatFits)
    }
}
