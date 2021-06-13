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
    @State private var date = Date()
    @State private var navigation : Int? = 0
    @State private var useMetric: Bool = false

    @State private var tab = 0

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
                        submit(date)
                    }, label: {
                        Text("✔︎")
                    })
                    .buttonStyle(CircleButton(bg:Color.green, fg: Color.white))
                    .padding()
                }
                .padding()

                Spacer()

                NavigationLink(
                    destination: RecordListView(),
                    tag: 1,
                    selection: $navigation,
                    label: {EmptyView()})
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        navigation = 1
                    }, label: {
                        Image(systemName: "list.bullet")
                    })
                }

                ToolbarItem(placement: .principal) {
                    Button(action: {
                    }, label: {
                        HStack {
                            Text(dateFormatter.string(from: date))
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
        Text(weight=="0" ? "****. **":weight).font(.title).fontWeight(.regular).foregroundColor(weight=="0" ? Color.gray:Color.primary)
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

    func submit(_ time: Date) {
        feedback.impactOccurred()

        if weight.last == "." {
            weight.append("0")
        }

        if let weightFloat = Float(weight) {
            print(weightFloat)
            print(date)
            PersistenceController.shared.add(weight: weightFloat, date: date)
            weight = "0"
            navigation = 1
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
