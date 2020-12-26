//
//  ContentView.swift
//  Share honestly
//
//  Created by Andrey Kudryavtsev on 22.12.2020.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home:View {
    
    init() {
        
        // color title UINavigationBar type .large...
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
        
        // color title UINavigationBar type .inline...
        UINavigationBar.appearance().barTintColor = .brown
        
        // set theme
        UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = .dark
    }
    
    // text cashier's check...
    @State private var cashierCheck = ""
    
    // Number of persons...
    @State private var numberPersons = 0
    
    // items array tips...
    @State private var tips = ["0", "5", "10", "15", "20", "25", "30", "35", "40",]
    
    // selected ++++++
    @State private var selectTips = 0
    
    // all summa ++++++
    @State private var total: Double = 0.0
    // ostatok +++++++
    @State private var differ: Double = 0.0
    @State private var tip: Double = 0.0
    @State private var difference: Double = 0.0
    @State private var colorDifference = false
    
    // show alert...
    @State private var showAlert = false
    
    // show alert limit amount...
    @State private var showMessageLimit = false
    
    // show alert invalid number format...
    @State private var showInvalidNumberFormat = false
    
    //function to keep text length in limits
    func limitText(_ upper: Int) {
        if cashierCheck.count > upper {
            cashierCheck = String(cashierCheck.prefix(upper))
        }
    }
    
    var body: some View {
        
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("Enter the amount manually")) {
                        VStack {
                            HStack {
                                Image(systemName: "dollarsign.circle.fill")
                                    .foregroundColor(.yellow)
                                TextField("Enter total summ", text: $cashierCheck)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(.white)
                                    .padding()
                                    .keyboardType(.decimalPad)
                                    .onReceive(Just(cashierCheck)) {_ in limitText(8)}
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 20))
                                Picker("Number of persons", selection: $numberPersons) {
                                    ForEach(2..<100) {
                                        Text("\($0) people")
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                }
                            }
                        }
                    }
                    Section(header: Text("Tips")) {
                        HStack {
                            Image(systemName: "giftcard.fill")
                                .foregroundColor(.yellow)
                            Picker(selection: $selectTips, label:
                                    Text("Tip percentage")
                                    .foregroundColor(.white)
                                    .padding()
                            ) {
                                ForEach(0..<tips.count) { index in
                                    Text(self.tips[index] + "%")
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            }
                        }
                    }
                    Section(header: Text("Total")) {
                        VStack(alignment: .leading) {
                            Text("Total = \(total, specifier: "%.2f")")
                                .foregroundColor(.orange)
                                .font(.system(size: 28))
                                .bold()
                                .padding(.top)
                                .padding(.horizontal)
                            Text("Tip = \(tip, specifier: "%.2f")")
                                .bold()
                                .foregroundColor(.yellow)
                                .padding(.horizontal)
                                .padding(.top, 5)
                            Text("Difference = \(difference, specifier: "%.2f")")
                                .bold()
                                .foregroundColor(colorDifference ? .red : .yellow)
                                .padding(.horizontal)
                                .padding(.bottom, 5)
                        }
                        Button(action: {
                            if !cashierCheck.isEmpty {
                                cashierCheck = cashierCheck.replacingOccurrences(of: ",", with: ".")
                                if cashierCheck.CharCount(input: cashierCheck, char: ".") {
                                    tip = ((Double(tips[selectTips]))! * (Double(cashierCheck)! / 100) * 100).rounded() / 100
                                    total = (((Double(cashierCheck)! + tip) / Double(numberPersons + 2)) * 100).rounded() / 100
                                    differ = ((total * Double(numberPersons + 2) - tip) * 100).rounded() / 100
                                    difference = (Double(cashierCheck)! - differ)
                                    if differ != 0 {
                                        difference.negate()
                                    }
                                    if Double(cashierCheck)! > differ {
                                        colorDifference = true
                                    } else {
                                        colorDifference = false
                                    }
                                } else {
                                    self.showInvalidNumberFormat.toggle()
                                }
                            }
                        }, label: {
                            Text("Calculate")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .padding()
                                .font(.system(size: 22))
                        }
                        )
                        .alert(isPresented: $showInvalidNumberFormat, content: {
                            Alert(title: Text("Share honestly"),
                                  message: Text("Invalid number format"),
                                  dismissButton: .default(Text("Ok")))
                        })
                        
                    }
                }
                .navigationBarTitle("Share honestly")
                .navigationBarItems(trailing: (
                    Button(action: {
                        self.showAlert.toggle()
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)))
                            .font(.system(size: 26))
                    })
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("About"),
                              message: Text("Chare honestly - Version 1.0.0\nXcode - Version 12.3 (12C33)\nSwift - 5.3\nFramework - SwiftUI\nCopyright © 2020 Andrey Kudryavtsev"),
                              dismissButton: .default(Text("Ok")))
                        
                    })
                ))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {
    func CharCount(input: String, char: Character) -> Bool {
        var letterCount = 0
        for letter in input {
            if letter == char {
                letterCount += 1
            }
        }
        return letterCount <= 1 ? true : false
    }
}
