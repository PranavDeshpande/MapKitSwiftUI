//
//  ContentView.swift
//  MapKitSwiftUI
//
//  Created by Pranav Shashikant Deshpande on 6/13/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // Difference between state and state variables
    // Difference between state and published
    @StateObject private var viewModel = ContentViewModel()
 
    
    
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            
            .onAppear{
                viewModel.checkIfLocationisEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


