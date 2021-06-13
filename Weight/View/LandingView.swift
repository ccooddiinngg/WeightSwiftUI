//
//  LandingView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/12/21.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showSheet = false

    let bg = LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)

    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(0..<7) { item in
                                dayCard().id(item)
                            }
                            dayCardAddNewButton().id(7)
                        }
                        .padding(5)
                        .onAppear {
                            proxy.scrollTo(7, anchor: .trailing)
                        }
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                InputView().environment(\.managedObjectContext, viewContext)
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
                Circle().fill(Color.accentColor).shadow(radius: 3)
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
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color.blue)
                    Text("12")
                        .font(.system(size: 24, weight: .regular, design: .default))
                        .foregroundColor(Color.gray)
                }.padding()


                Button(action: {showSheet.toggle()}, label: {
                    Text("*")
                        .font(.system(size: 24, weight: .regular, design: .default))
                        .foregroundColor(Color.primary)
                        .padding(5)

                })
                .padding(5)
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .foregroundColor(Color(.systemGray5))

            }
            .padding(5)
            .frame(width: 120, height: 160)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray5)))

    }

    func dayCardAddNewButton() -> some View {
        VStack {
            addButton()
        }
        .frame(width: 120, height: 160)
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray5)))

    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
