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
    @State private var weight = 1500
    @State private var limit = 3600

    var body: some View {

        ZStack {
            Color.green
            VStack {
                Spacer()
                ScaleView(weight: $weight, hideBottomBar: $hideBottomBar, limit: $limit)
                    .offset(x:0, y:hideBottomBar ? 180:0).animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
            }
        }.ignoresSafeArea()

    }


}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
