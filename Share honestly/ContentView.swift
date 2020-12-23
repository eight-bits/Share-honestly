//
//  ContentView.swift
//  Share honestly
//
//  Created by Andrey Kudryavtsev on 22.12.2020.
//

import SwiftUI

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
    @State private var numberPersons = 2
    
    // items array tips...
    @State private var tips = ["0", "5", "10", "15", "20", "25", "30", "35", "40",]
    
    // selected
    @State private var selectTips = 0
    
    // all summa...
    @State private var total: Double = 0.0
    
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
                        Text("Total = \(total, specifier: "%.2f")")
                            .foregroundColor(.orange)
                            .font(.system(size: 28))
                            .bold()
                            .padding()
                        Button(action: {
                            if !cashierCheck.isEmpty {
                                let newCachierCheck = cashierCheck.replacingOccurrences(of: ",", with: ".")
                                let tmp = (Double(self.tips[selectTips])! / 10.0) * (Double(newCachierCheck)! / 10.0)
                                self.total = ((Double(newCachierCheck)! + tmp) / Double(numberPersons + 2))
                            }
                        }, label: {
                            Text("Calculate")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .padding()
                        })
                    }
                }
                .navigationBarTitle("Share honestly")
                .navigationBarItems(trailing: (
                        Button(action: {
                            print("12345")
                        }, label: {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)))
                                .font(.system(size: 26))
                        })))
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
