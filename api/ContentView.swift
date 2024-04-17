//
//  ContentView.swift
//  api
//
//  Created by WADE, DANIEL A. on 4/15/24.
//

import SwiftUI
//https://x-colors.yurace.pro/api/random/blue
//https://github.com/cheatsnake/xColors-api?tab=readme-ov-file

struct ContentView: View {
    struct ColorConverter: Codable {
        var hex: String
        var rgb: String
        var hsl: String
    }
    
    struct Result: Codable {
        var items: [ColorConverter]
    }
    
    @State var colors:ColorConverter = ColorConverter(hex: "#FFFFF", rgb: "255, 255, 255", hsl: "100, 100%, 100%")
    @State var pureRGB: [String.SubSequence] = []
    
    var body: some View {
        
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            if pureRGB == [] {
                Text("Hello world")
            }
            else {
                Text(String(_:pureRGB[1]))
            }

            Button(action: {
                getColor(colorBase: "red")
            }, label: {
                Text("Generate Color a red color")
            })
            
            Button("Get Color", action: {
                getColor(colorBase: "red")
                
            })
            
        }
        .padding()
    }
    
    func getColor(colorBase: String) {

        if let apiUrl = URL(string: "https://x-colors.yurace.pro/api/random/\(colorBase)") {
            
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { data, request, error in
                if let colorData = data {
                    print(colorData)
                    if let colorsFromAPI = try? JSONDecoder().decode(ColorConverter.self, from: colorData) {
                        colors = colorsFromAPI
                        pureRGB = colors.rgb.split(separator: ", ")
                        print(pureRGB)
                    }
                }
    
            }.resume()
            
        }
    }
}

#Preview {
    ContentView()
}
