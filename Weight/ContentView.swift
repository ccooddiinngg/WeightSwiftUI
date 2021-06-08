//
//  ContentView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/4/21.
//

import SwiftUI
import CoreData
import AVFoundation

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var useMetric = false
    @State private var weight = 0.0
    @State private var showPanel = false

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button(action: {
                    showPanel.toggle()
                }, label: {
                    ZStack {
                        Circle().fill(Color.green).frame(height: 70).shadow(radius: 3)
                        Image(systemName: "plus").font(.system(size: 56, weight: .regular, design: .rounded)).foregroundColor(.white)
                    }.padding()
                })
            }
            .sheet(isPresented: $showPanel) {
                InputView()
            }
        }.ignoresSafeArea()

    }

    func onSubmit(weight: Double) {
        self.weight = weight
        print(self.weight)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
