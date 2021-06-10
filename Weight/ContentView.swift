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
    @State private var tag = 0
    var body: some View {
        TabView {
            ChartView().tabItem { Image(systemName: "chart.bar.xaxis") }.tag(0)
            InputView().tabItem {Image(systemName: "plus.circle.fill")}.tag(1)
            SettingView().tabItem {Image(systemName: "gearshape.fill")}.tag(2)
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
