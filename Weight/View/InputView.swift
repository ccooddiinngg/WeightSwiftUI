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
            GeometryReader {proxy in
                ZStack {
                    Color.clear.ignoresSafeArea()
                    VStack {
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

                        Divider()
                        buildCards()
                        Divider()

                        let columns = Array(repeating: GridItem(.fixed(80)), count: 3)
                        VStack {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
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
                            }
                        })
                    }
                }
            }
        }
    }

    func buildCards() -> some View {
        let today = PersistenceController.shared.fetchRecordOn(date: Date())
        let yesterday = PersistenceController.shared.fetchRecordOn(date: Date().addingTimeInterval(TimeInterval(-24 * 60 * 60)))
        let twoDaysAgo = PersistenceController.shared.fetchRecordOn(date: Date().addingTimeInterval(TimeInterval(-48 * 60 * 60)))

        return
            HStack {
                buildCard(on: twoDaysAgo, title: "2 Days")
                buildCard(on: yesterday, title: "Yesterday")
                buildCard(on: today, title: "Today")
            }

    }

    func buildCard(on record: WeightRecord?, title: String) -> some View {
        let weight = record == nil ? "-.-" : String(format: "%.2f",record!.weight)

        return ZStack {
            RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1)
            VStack {
                Text(weight)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                    .padding()

                Text(title)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                    .padding()
            }
        }.padding(5)
        .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
