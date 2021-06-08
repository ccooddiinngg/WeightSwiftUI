//
//  ScaleView.swift
//  Weight
//
//  Created by Hanjun Kang on 6/5/21.
//

import SwiftUI

struct ScaleView: View {
    @Binding var weight: Int
    @Binding var hideBottomBar: Bool
    @Binding var limit: Int

    let date: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: Date())
    }()

    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(hideBottomBar ? Color.green:Color.white)
            VStack {
                if !hideBottomBar {
                    Text(date).font(.headline).foregroundColor(.gray).padding()
                }
                Spacer()
                HStack {
                    Button(action: {decrease(by: 10)}) {
                        Image(systemName: "backward").font(.system(size: 30, weight: .thin, design: .default)).foregroundColor(.blue).padding()
                    }
                    Button(action: {decrease(by: 1)}) {
                        Image(systemName: "backward.frame").font(.system(size: 30, weight: .thin, design: .default)).foregroundColor(.blue).padding()
                    }

                    ZStack {
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)))
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)))
                            .frame(width: 110, height: 110, alignment: .center)
                        VStack {
                            Image(systemName: "circlebadge.fill")
                                .padding(2)
                                .foregroundColor(hideBottomBar ? .green:.red)

                            Text("\(weight/10).\(weight%10)")
//                                    .font(Font.custom("Technology", size: 40))
                                .font(.largeTitle)
                                .foregroundColor(.blue)

                            Text("lb")
                                .font(.footnote)
                                .foregroundColor(.blue).padding(2)
                        }
                    }
                    .frame(width: 120, height: 120, alignment: .center)
                    .offset(x: 0, y: hideBottomBar ? -90:0)
                    .onTapGesture {
                        hideBottomBar.toggle()
                    }

                    Button(action: {increase(by: 1)}) {
                        Image(systemName: "forward.frame").font(.system(size: 30, weight: .thin, design: .default)).foregroundColor(.blue).padding()
                    }
                    Button(action: {increase(by: 10)}) {
                        Image(systemName: "forward").font(.system(size: 30, weight: .thin, design: .default)).foregroundColor(.blue).padding()
                    }
                }
                Spacer()
            }
        }
        .frame(height: 300, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 3, x: 5, y: 5)

    }

    func decrease(by number: Int) {
        if weight > number {
            weight -= number
        }
    }

    func increase(by number: Int) {
        if weight < limit - number {
            weight += number
        }
    }

}


struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleView(weight: .constant(1500), hideBottomBar: .constant(false), limit: .constant(3600)).previewLayout(.sizeThatFits)
    }
}
