//
//  AddNewTagView.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/25.
//

import SwiftUI

struct AddNewTagView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var selectedColor: Color = .blue

    let onSave: (String, UIColor) -> Void

    private var isFormValid: Bool {
        !name.isEmptyOrWhitespace
    }

    var body: some View {
      VStack {
          VStack {
              Image(systemName: "line.3.horizontal.circle.fill")
                  .foregroundColor(selectedColor)
                  .font(.system(size: 100))
              TextField("List Name", text: $name)
                  .multilineTextAlignment(.center)
                  .textFieldStyle(.roundedBorder)
          }
          .padding(30)
          .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))

          ColorPickerView(selectedColor: $selectedColor)

          Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .toolbar {
          ToolbarItem(placement: .principal) {
              Text("New MissionTag")
                  .font(.headline)
          }

          ToolbarItem(placement: .navigationBarLeading) {
              Button("Close") {
                  dismiss()
              }
          }

          ToolbarItem(placement: .navigationBarTrailing) {
              Button("Done") {
                  onSave(name, UIColor(selectedColor))
                  dismiss()
              }
              .disabled(!isFormValid)
          }
      }
    }
}

struct AddNewTagView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTagView(onSave: { (_, _) in })
    }
}
