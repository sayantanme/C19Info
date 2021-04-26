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
        NavigationView {
            List(model.oxygenModel, id: \.id){ data in
                O2DataView(o2data: data)
                    .padding(2)
                    //.shadow(radius: 4)
            }
            .listStyle(SidebarListStyle())
            .navigationBarTitle("Oxygen Data")
        }.navigationViewStyle(StackNavigationViewStyle())
        
        .onAppear(perform: {
                model.getOxygenRelatedInfo()
            })
    }
}

struct O2DataView: View {
    var o2data: O2Data
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 6) {
                Text("Name : \(o2data.name.text) \(o2data.companyName.text)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                Text("Phone(s) : \(o2data.phone1.text) \(o2data.phone2.text)")
                    .font(.subheadline)
                    .fontWeight(.black)
                    .lineLimit(2)
                if let cmnt = o2data.comment {
                    Text("Comment: \(cmnt)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)

                }
                
                if let verifiedDate = o2data.lastVerifiedOn, let stringifiedDate = verifiedDate.convertToString() {
                    Text("Verified Date: \(stringifiedDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                }
                
                Text("Location: \(o2data.district.text) \(o2data.state.text)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
            }
            .layoutPriority(100)
            Spacer()
        }
        .padding()
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue))
        
        //.padding([.top, .horizontal])
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
