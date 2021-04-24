//
//  ContentView.swift
//  C19Info
//
//  Created by Sayantan Chakraborty on 24/04/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = OxygenVM()
    var body: some View {
        Text("Hello, world!")
            .padding()
        
            .onAppear(perform: {
                model.getOxygenRelatedInfo()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
