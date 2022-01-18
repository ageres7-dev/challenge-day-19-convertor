//
//  ContentView.swift
//  Convertor
//
//  Created by Sergey Dolgikh on 11.01.2022.
//

import SwiftUI

enum TemperatureType: String {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

struct ContentView: View {
    @State private var convertFrom = TemperatureType.celsius
    @State private var convertTo = TemperatureType.fahrenheit
    @State private var enteredValue = 0.0
    @FocusState private var isFocused: Bool
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value", value: $enteredValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("From", selection: $convertFrom) {
                        ForEach(temperatureFormats, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
                .headerProminence(.increased)
                
                Section() {
                    Picker("To", selection: $convertTo) {
                        ForEach(temperatureFormats, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(convertedValue, format: .number)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .font(.largeTitle)
                } header: {
                    Text("To")
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
    
    private let temperatureFormats: [TemperatureType] = [
        .celsius,
        .fahrenheit,
        .kelvin
    ]
    
    private var convertedValue: Double {
        let fromTypeTemperature = getUnitTemperature(from: convertFrom)
        let toTypeTemperature = getUnitTemperature(from: convertTo)
        let enteredTemperature = Measurement(value: enteredValue, unit: fromTypeTemperature)
        
        let result = enteredTemperature.converted(to: toTypeTemperature).value
        return result
    }
    
    private func getUnitTemperature(from temperatureType: TemperatureType) -> UnitTemperature {
        switch temperatureType {
        case .celsius:
            return UnitTemperature.celsius
        case .fahrenheit:
            return UnitTemperature.fahrenheit
        case .kelvin:
            return UnitTemperature.kelvin
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
