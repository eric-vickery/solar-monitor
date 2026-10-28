//
//  ContentView.swift
//  SolarMonitor
//
//  Created by Eric Vickery on 2/21/20.
//  Copyright © 2020 Eric Vickery. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mqttDevice: MQTTDevice

    var body: some View {
        SolarSystemUIView(device: mqttDevice)
    }
}
