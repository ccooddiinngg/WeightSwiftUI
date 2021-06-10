//
//  InputView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/5/21.
//

import SwiftUI

struct InputView: View {

    @State private var weight = "0"
    @State private var date = Date()
    @State private var warning = " "
    @State private var navigation : Int? = 0
    @State private var useMetric: Bool = false

    private let textArray = ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "✗"]
    private let digitLimit = 4
    private let decimalLimit = 2

    let feedback = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("_Charcoal")
                VStack {
                    NavigationLink(
                        destination: DatePickerView(date: $date),
                        tag: 1,
                        selection: $navigation,
                        label: {EmptyView()})

                    NavigationLink(
                        destination: RecordListView(),
                        tag: 2,
                        selection: $navigation,
                        label: {EmptyView()})


                    VStack(alignment: .center) {
                        Text("\(weight)")
                            .font(.largeTitle)
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .padding()

                        Text(warning)
                            .font(.footnote)
                            .foregroundColor(.white)
                    }

                    let columns = Array(repeating: GridItem(.fixed(80)), count: 3)

                    VStack {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                            ForEach(textArray, id:\.self) {key in
                                Button(action: {
                                    handleInput(key)
                                }, label: {
                                    Text(key)
                                })
                                .buttonStyle(CircleButton(bg: Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)), fg: Color.primary))
                            }
                        }

                        Button(action: {
                            submit(date)
                        }, label: {
                            Text("✔︎")
                        })
                        .buttonStyle(CircleButton(bg:Color.green, fg: Color.white))
                        .padding()

                    }
                    .padding()

                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigation = 1
                    }, label: {
                        HStack {
                            Text(dateFormatter.string(from: date))
                            Image(systemName: "calendar.circle.fill")
                        }.foregroundColor(.white)
                    })

                }

            }
            .ignoresSafeArea()

        }
    }

    struct CircleButton: ButtonStyle {
        var bg: Color
        var fg: Color

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .font(.largeTitle)
                .foregroundColor(fg)
                .background(
                    ZStack {
                        Circle().fill(bg)
                    }.frame(width: 70, height: 70, alignment: .center).shadow(radius: configuration.isPressed ? 0:1)
                )
        }

    }

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    func handleInput(_ key: String) {
        if key == "✗" {
            feedback.impactOccurred()
            weight = "0"
            warning = " "
            return
        }

        if key == "."  {
            if !weight.contains(".") {
                weight.append(".")
            }
            warning = " "
            return
        }

        if weight.first == "0" && !weight.contains(".") {
            weight = key
        }else if weight.contains(".") && weight.suffix(from: weight.firstIndex(of: ".")!).count >= decimalLimit + 1 {
            warning = "\(decimalLimit) decimal place accuracy only."
        }else if (!weight.contains(".") && weight.count >= digitLimit)  || (weight.contains(".") && weight.prefix(while: {$0 != "."}).count > digitLimit) {
            warning = "\(digitLimit)-digit number only."
        }else {
            weight.append(key)
        }


    }

    func submit(_ time: Date) {
        feedback.impactOccurred()

        if weight.last == "." {
            weight.append("0")
        }

        if let weightDouble = Double(weight) {
            print(weightDouble)
            print(time)
            weight = "0"
            warning = " "
            navigation = 2
        }
    }

}


struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputView().previewLayout(.sizeThatFits)
        }
    }
}
