//
//  ColorPickerView.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/26.
//

import SwiftUI

struct ColorPickerView: View {

    @Binding var selectedColor: Color

    let colorList: [Color] = ColorListVal

    let columns = [
            GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10),
            GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10),
            GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10),
            GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10),
            GridItem(.flexible(minimum: 45, maximum: 100), spacing: 10)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns,spacing: 16) {
                ForEach(colorList, id: \.self) { color in
                    ZStack{
                        Circle().fill()
                            .foregroundColor(color)
                            .padding(5)
                        Circle()
                            .strokeBorder(selectedColor == color ? .gray: .clear, lineWidth: 4)
                            .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    }.onTapGesture {
                        selectedColor = color
                    }
                }
            }
            .padding(20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(selectedColor: .constant(.blue))
    }
}
