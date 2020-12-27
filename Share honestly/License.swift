//
//  License.swift
//  Share honestly
//
//  Created by Andrey Kudryavtsev on 27.12.2020.
//

import SwiftUI

struct License: View {
    
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>
    
    init() {
        UIApplication.shared.windows.first?.self.overrideUserInterfaceStyle = .dark
    }
    
    let arrayTextAlig = ["text.alignleft", "text.aligncenter",]
    @State private var selectTextAlig = 0
    
    var body: some View {
        NavigationView{
            VStack {
                Picker(selection: $selectTextAlig, label: Text("Select"), content: {
                    ForEach(0..<self.arrayTextAlig.count) {i in
                        Image(systemName: self.arrayTextAlig[i])
                    }
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 50)
                .padding(.horizontal, 10)
                Text("You must understand that the application may contain errors and the author of the program does not bear any responsibility if, because of them, the calculation is not correct. By continuing to use the program, you agree to this condition. If you do not agree with this condition, remove the program from the device and do not use it.")
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
                    .multilineTextAlignment(self.selectTextAlig == 0 ? .leading : .center)
                Spacer()
                Button(action: {
                    self.presentMode.wrappedValue.dismiss()
                },
                label: {
                    Text("Accept the agreement and continue")
                        .font(.body)
                        .font(.system(size: 20))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.bottom, 50)
                })
                .colorScheme(.dark)
            }
            .navigationBarTitle("License", displayMode: .inline)
        }
    }
}

struct License_Previews: PreviewProvider {
    static var previews: some View {
        License()
    }
}
