//
//  BottomDrawer.swift
//  Weight
//
//  Created by Hanjun Kang on 6/11/21.
//

import SwiftUI

struct BottomDrawer: View {
    @Binding var show: Bool
    var body: some View {
        ZStack {
            Color("_Charcoal")
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .animation(.easeIn)
        .frame(height: 200).offset(x: 0, y: show ? 358: 658)
    }
}

struct BottomDrawer_Previews: PreviewProvider {
    static var previews: some View {
        BottomDrawer(show: .constant(true))
    }
}
