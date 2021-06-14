//
//  CardView.swift
//  Best
//
//  Created by Hanjun Kang on 5/20/21.
//

import SwiftUI

struct CardView<Content: View>: View {
    var content: Content
    var color: Color

    @State var offset: CGSize = CGSize(width: 0, height: 0)

    init(content: Content, color: Color = Color.blue) {
        self.color = color
        self.content = content
    }

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Rectangle().stroke(color)
                HStack {
                    color
                        .frame(width: 6)

                    VStack {
                        content
                    }
                    .offset(offset)
                    .onAppear {
                        withAnimation(.easeIn) {
                            offset.width = 0
                        }
                    }
                }
            }
            .cornerRadius(5, corners: [.topLeft, .bottomLeft])

        }
    }


}


