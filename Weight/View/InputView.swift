//
//  InputView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/5/21.
//

import SwiftUI

struct InputView: View {
    @Environment(\.presentationMode) var presentation
    @State private var weight = "0"
    @State private var useMetric: Bool = false
    @State private var tab = 0

    @Binding var selected: Weight

    private let textArray = ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "✗"]
    private let digitLimit = 4
    private let decimalLimit = 2

    let feedback = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                buildDisplayWindow()
                Divider()
                let columns = Array(repeating: GridItem(.fixed(60)), count: 3)
                VStack {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                        ForEach(textArray, id:\.self) {key in
                            Button(action: {
                                handleInput(key)
                            }, label: {
                                Text(key).foregroundColor(.black)
                            })
                            .buttonStyle(CircleButton(bg: Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)), fg: Color.primary))
                        }
                    }

                    Button(action: {
                        submit()
                    }, label: {
                        Text("✔︎")
                    })
                    .buttonStyle(CircleButton(bg:Color.accentColor, fg: Color.white))
                    .padding()
                }
                .padding()

                Spacer()
            }
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Button(action: {
                    }, label: {
                        HStack {
                            Text(dateFormatter.string(from: selected.date))
                        }
                    })
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                }

            })

        }
    }

    

    func buildDisplayWindow() -> some View {
        let text = selected.weight == 0 ? "****.**":String(format: "%.2f", selected.weight)
        return
            Text(weight=="0" ? text:weight).font(.title).fontWeight(.regular).foregroundColor(weight=="0" ? Color.gray:Color.primary)
    }

    struct CircleButton: ButtonStyle {
        var bg: Color
        var fg: Color

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .font(.title2)
                .foregroundColor(fg)
                .background(
                    ZStack {
                        Circle().fill(bg)
                    }.frame(width: 60, height: 60, alignment: .center).shadow(radius: configuration.isPressed ? 0:1)
                )
        }

    }

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var dateFormatterShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    func handleInput(_ key: String) {
        if key == "✗" {
            feedback.impactOccurred()
            weight = "0"
            return
        }

        if key == "."  {
            if !weight.contains(".") {
                weight.append(".")
            }
            return
        }

        if weight.first == "0" && !weight.contains(".") {
            weight = key
        }else if weight.contains(".") && weight.suffix(from: weight.firstIndex(of: ".")!).count >= decimalLimit + 1 {
            print( "\(decimalLimit) decimal place accuracy only.")
        }else if (!weight.contains(".") && weight.count >= digitLimit)  || (weight.contains(".") && weight.prefix(while: {$0 != "."}).count > digitLimit) {
            print( "\(digitLimit)-digit number only.")
        }else {
            weight.append(key)
        }


    }

    func submit() {
        feedback.impactOccurred()

        if weight.last == "." {
            weight.append("0")
        }

        if let weightFloat = Float(weight) {
            print(weightFloat)
            print(selected.date)
            PersistenceController.shared.add(weight: weightFloat, date: selected.date)
            weight = "0"
            presentation.wrappedValue.dismiss()
        }
    }

}

