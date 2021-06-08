//
//  InputView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/5/21.
//

import SwiftUI

struct InputView: View {
    @StateObject private var dataCenter = InputManager()
    @Environment(\.presentationMode) var presentation

    var body: some View {
        GeometryReader {proxy in
            ZStack(alignment: .center) {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            presentation.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark.circle").imageScale(.large).padding()
                        })
                    }

                    Spacer()

                    VStack(alignment: .center) {
                        Text("\(dataCenter.weight)")
                            .font(.system(size: 50, weight: .medium, design: .rounded))
                            .fontWeight(.regular)
                            .foregroundColor(.primary)

                        Text(dataCenter.warning).font(.footnote).opacity(0.8).frame(height: 20)

                    }.frame(height: 100)

                    let columns = Array(repeating: GridItem(.fixed(80)), count: 3)
                    LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                        ForEach(dataCenter.textArray, id:\.self) {key in
                            Button(action: {
                                dataCenter.handleInput(key)
                            }, label: {
                                Text(key)
                            })
                            .buttonStyle(CircleButton(bg: Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)), fg: Color.primary))
                        }
                    }

                    Button(action: {
                        dataCenter.handleInput("✔︎")
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("✔︎")
                    })
                    .buttonStyle(CircleButton(bg:Color.green, fg: Color.white))
                    .padding(.vertical, 10)

                    Spacer()

                }
            }
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

    

}


struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        InputView().previewLayout(.sizeThatFits)
    }
}
