//
//  InputView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/5/21.
//

import SwiftUI

struct InputView: View {
    @StateObject private var inputManager = InputManager()
    @Environment(\.presentationMode) var presentation

    var body: some View {
        GeometryReader {proxy in
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.green).imageScale(.large).padding()
                    })
                }

                VStack(alignment: .center) {

                    Text("\(inputManager.weight)")
                        .font(.system(size: 50, weight: .medium, design: .rounded))
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                        .padding()

                    Text(inputManager.warning)
                        .font(.footnote)
                        .opacity(0.8)
                        .frame(height: 20)

                }
                .frame(height: 150)

                Divider()

                let columns = Array(repeating: GridItem(.fixed(80)), count: 3)
                LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                    ForEach(inputManager.textArray, id:\.self) {key in
                        Button(action: {
                            inputManager.handleInput(key)
                        }, label: {
                            Text(key)
                        })
                        .buttonStyle(CircleButton(bg: Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)), fg: Color.primary))
                    }
                }.padding()

                Button(action: {
                    inputManager.handleInput("✔︎")
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("✔︎")
                })
                .buttonStyle(CircleButton(bg:Color.green, fg: Color.white))
                .padding(.vertical, 10)
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
