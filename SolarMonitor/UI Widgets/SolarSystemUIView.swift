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
            Text(device.getName())
            .font(.largeTitle)
            .bold()
            HStack(spacing: 20) {
                Text("Available Solar")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.availableSolarPower + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Solar Harvest")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.currentSolarPower + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Load")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.currentLoadPower + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery Voltage")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batteryVoltage + " V")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery SOC")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batterySOC + "%")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery Amps")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batteryAmps + " A")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery Power")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batteryPower + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Battery Temperature")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.batteryTemperatureC + " C / " + device.batteryTemperatureF + " F")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text("")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
        VStack {
            Text("House")
                .font(.largeTitle)
                .bold()
            HStack(spacing: 20) {
                Text("EV Charger")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.evCharger + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Well Pump")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.wellPump + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Shop 120")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.southAndWest120 + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Shop 240")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.southAndWest240 + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Wet Wall")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.wetWall + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Air Compressor")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.airCompressor + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Welder")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.welder + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 20) {
                Text("Dust Collector")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                Text(device.dustCollector + " W")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            VStack
            {
                HStack(spacing: 20) {
                    Text("Kitchen West Plugs")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.kitchenWestWallPlugs + " W")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("Kitchen South Plugs")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.kitchenSouthWallPlugs + " W")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("Stove/Dishwasher")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.stoveDishwasher + " W")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("LR Pellet & TV")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.livingRoomPelletAndTV + " W")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("Kate's Office")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.kateOffice + " W")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("Eric's Office")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.ericOffice + " W")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("Master Bedroom")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.masterBedroom + " W")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("Master Bath & Pellet")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.masterBathAndPellet + " W")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("Solar Room Temp")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.solarRoomTemperature + " F")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    Text("Utility Room Temp")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(device.utilityRoomTemperature + " F")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        HStack(spacing: 20) {
            Text("")
                .font(.headline)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            Text("")
                .font(.headline)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        HStack(spacing: 20) {
            Text("Last Published Time")
                .font(.headline)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            Text(device.lastPublishedTime)
                .font(.headline)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
    }
}

//struct SolarSystemUIView_Previews: PreviewProvider {
//    static var baseDevice = BaseDevice.loadFromFile(deviceName: "Combox", testMode: true)
//    static var previews: some View {
//        SolarSystemUIView(device: baseDevice!)
//    }
//}
