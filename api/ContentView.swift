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
            if pureRGB == [] {
                Text("")
            }
            else {
                Circle()
                    .fill(Color(red: Double(pureRGB[0])!/255, green: Double(pureRGB[1])!/255, blue: Double(pureRGB[2])!/255))
            }

            Button(action: {
                getColor(colorBase: "red")
            }, label: {
                Text("Generate a red color")
                    .tint(.red)
            })
            Button(action: {
                getColor(colorBase: "green")
            }, label: {
                Text("Generate a green color")
                    .tint(.green)
            })
            Button(action: {
                getColor(colorBase: "blue")
            }, label: {
                Text("Generate a blue color")
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
                    if let colorsFromAPI = try?
                        JSONDecoder().decode(ColorConverter.self, from: colorData) {
                        colors = colorsFromAPI
                        print(colors.rgb)
                        pureRGB = colors.rgb.prefix(colors.rgb.count-1).suffix(colors.rgb.count-5).split(separator: ", ")
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
