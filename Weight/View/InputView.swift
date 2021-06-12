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
                Divider()
                buildDisplayWindow()
                Divider()

                let columns = Array(repeating: GridItem(.fixed(50)), count: 3)
                VStack {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
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

                NavigationLink(
                    destination: DatePicker("", selection: $date, displayedComponents: [.date]).datePickerStyle(GraphicalDatePickerStyle()),
                    tag: 1,
                    selection: $navigation,
                    label: {EmptyView()})

                NavigationLink(
                    destination: RecordListView(),
                    tag: 2,
                    selection: $navigation,
                    label: {EmptyView()})
            }
            .navigationBarHidden(true)

        }
    }

    

    func buildDisplayWindow() -> some View {
        HStack {
            Button(action: {
                navigation = 1
            }, label: {
                HStack {
                    Text(dateFormatter.string(from: date))
                    Image(systemName: "calendar.circle.fill")
                }
            })
            Text(weight).font(.title).fontWeight(.regular).foregroundColor(Color("_Black"))
                .frame(width: 120)
        }.padding(5)
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
                    }.frame(width: 50, height: 50, alignment: .center).shadow(radius: configuration.isPressed ? 0:1)
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
