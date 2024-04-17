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
    struct ColorConvert: Codable {
        var hex: String
        var rgb: String
        var hsl: String
    }
    
    struct Result: Codable {
        var item: ColorConvert
    }
    
    @State var color: ColorConvert
    var apiColor: Color
    var body: some View {
        
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
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
                    if let colorFromAPI = try? JSONDecoder().decode(Result.self, from: colorData) {
                        color = colorFromAPI.item
                        print(colorFromAPI)
                    }
                    
                }
    
            }.resume()
            
            /*
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { data, request, error in
                if let colorData = data {
                    
                    if let colorsFromAPI = try? JSONDecoder().decode(Result.self, from: colorData) {
                        colors = colorsFromAPI.items
                        print(colors)
                    }
                }
    
            }.resume()
            */
        }
    }
}

#Preview {
    ContentView()
}
