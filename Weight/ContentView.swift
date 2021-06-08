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
    @State private var hideBottomBar = false
    @State private var useMetric = false
    @State private var weight = 0.0

    var body: some View {

        ZStack {
            Color.green
            VStack {
                Spacer()
                ScaleView(weight: $weight, useMetric: $useMetric, hideBottomBar: $hideBottomBar, onSubmit: onSubmit)
                    .offset(x:0, y:hideBottomBar ? 180:0).animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
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
