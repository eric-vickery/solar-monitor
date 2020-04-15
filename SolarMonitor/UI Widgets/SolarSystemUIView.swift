//
//  SolarSystemUIView.swift
//  SolarMonitor
//
//  Created by Eric Vickery on 4/2/20.
//  Copyright © 2020 Eric Vickery. All rights reserved.
//

import SwiftUI

struct SolarSystemUIView: View {
    @ObservedObject var device: BaseDevice

    var body: some View {
        VStack {
            Text(device.getTypeName())
            .font(.largeTitle)
            .bold()
            HStack(spacing: 20) {
                Text("Solar")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.solarPower)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Load")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.loadPower)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery Voltage")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batteryVoltage)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery SOC")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batterySOC)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery Amps")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batteryAmps)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery Power")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batteryPower)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery Temperature")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batteryTemperature)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct RowLabel : View {
    var label: String
    var body: some View {
        ZStack(alignment: .trailing) {
            Text("Battery Temperature")
                .opacity(0)
                .accessibility(hidden: true)
            Text(label)
//                .multilineTextAlignment(.trailing)
        }
    }
}

//struct SolarSystemUIView_Previews: PreviewProvider {
//    static var baseDevice = BaseDevice.loadFromFile(deviceName: "Combox", testMode: true)
//    static var previews: some View {
//        SolarSystemUIView(device: baseDevice!)
//    }
//}
