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
    @StateObject var tabManager = TabManager(tabSelected: 0, functionTab: 1)

    var body: some View {
        TabView(selection: $tabManager.tabSelected) {
            ChartView().tabItem { Image(systemName: "chart.bar.xaxis") }.tag(0)
            InputView().tabItem {Image(systemName: "plus.circle.fill")}.tag(1)
            SettingView().tabItem {Image(systemName: "gearshape.fill")}.tag(2)
        }
        .sheet(isPresented: $tabManager.functionTabSelected) {
            InputView()
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}