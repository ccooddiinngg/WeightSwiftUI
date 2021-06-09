//
//  AddButton.swift
//  Weight
//
//  Created by Hanjun Kang on 6/8/21.
//

import SwiftUI

struct AddButton: View {
    @State private var showInputPanel = false

    var body: some View {
        ZStack{
            Button(action: {
                showInputPanel.toggle()
            }, label: {
                ZStack {
                    Circle().fill(Color.green).frame(height: 50).shadow(radius: 3)
                    Image(systemName: "plus").font(.system(size: 40, weight: .regular, design: .rounded)).foregroundColor(.white)
                }.padding(.vertical, 10)
            })
        }
        .sheet(isPresented: $showInputPanel) {
            InputView()
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton().previewLayout(.sizeThatFits)
    }
}
