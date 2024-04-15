//
//  ContentView.swift
//  api
//
//  Created by WADE, DANIEL A. on 4/15/24.
//

import SwiftUI
//https://x-colors.yurace.pro/api/random/blue

struct ContentView: View {
    struct Color: Codable {
        var hex: String
        var rgb: String
        var hsl: String
    }
    
    struct Result: Codable {
        var items: [Color]
    }
    
    @State var colors:[Color] = []
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
