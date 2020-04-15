//
//  ContentView.swift
//  SolarMonitor
//
//  Created by Eric Vickery on 2/21/20.
//  Copyright © 2020 Eric Vickery. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var outbackDevice: Outback
    @ObservedObject var comboxDevice: Combox

    var body: some View {
        VStack(spacing: 30) {
            SolarSystemUIView(device: outbackDevice)
            SolarSystemUIView(device: comboxDevice)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
