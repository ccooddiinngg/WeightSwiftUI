//
//  LandingView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/12/21.
//

import SwiftUI

struct LandingView: View {
    @State private var showSheet = false
    @State private var selection = "None"
    let bg = LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)

    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<7) { item in
                                dayCard().id(item)
                            }
                        }.onAppear {
                            proxy.scrollTo(6, anchor: .center)
                        }
                    }
                }

            }
            .sheet(isPresented: $showSheet) {
                InputView()
            }
            .navigationTitle("Daca")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Tuesday 13").foregroundColor(.gray)
                }
            }
        }
    }

    func addButton() -> some View {
        Button(action: {

        }, label: {
            ZStack {
                Circle().fill(Color.green).shadow(radius: 3)
                Image(systemName: "plus")
                    .font(.system(size: 40, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
            }
            .frame(width: 50, height: 50)
        })
    }

    func dayCard() -> some View {
        VStack {
            HStack {
                Text("Tue")
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .foregroundColor(.blue)
                Text("12")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(Color(.gray))
            }
            .padding(5)
            Button(action: {showSheet.toggle()}, label: {
                Text("165.0")
                    .font(.system(size: 24, weight: .regular, design: .default))
                    .foregroundColor(Color(.gray))
                    .padding(5)
            })
        }
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color(.systemGray4)))

    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
