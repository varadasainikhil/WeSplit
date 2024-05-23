//
//  ContentView.swift
//  WeSplit
//
//  Created by Sai Nikhil Varada on 5/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocussed : Bool
        
    let tipPercentages = [10, 15, 20, 25, 0]
        
    var totalCheckAmount : Double {
        let tip = checkAmount * Double(tipPercentage)/100
        return checkAmount + tip
    }
    var totalPerPerson : Double{
        let peopleCount = Double(numberOfPeople)
        return totalCheckAmount / peopleCount
    }
        
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount ", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocussed)
                    
                    Picker("Number of people",selection: $numberOfPeople){
                        ForEach(2..<100, id: \.self){
                            Text("\($0) People")
                        }
                    }
                }
                Section("Select the Tip Percentage"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total Check Amount"){
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocussed{
                    Button("Done"){
                        amountIsFocussed = false
                    }
                }
            }
        }
    }
}

#Preview {
ContentView()
}

