//
//  BaseDevice.swift
//  Solar Monitor
//
//  Created by Eric Vickery
//

import Foundation
import CocoaMQTT

class BaseDevice: NSObject, ObservableObject
{
    // Solar Data
    @Published var lastPublishedTime = ""
    @Published var availableSolarPower = ""
    @Published var currentSolarPower = ""
    @Published var currentLoadPower = ""
    @Published var batteryVoltage = ""
    @Published var batterySOC = ""
    @Published var batteryAmps = ""
    @Published var batteryPower = ""
    @Published var batteryTemperatureF = ""
    @Published var batteryTemperatureC = ""
    @Published var chargerState = ""
    // House Data
    @Published var wellPump = ""
    @Published var evCharger = ""
    @Published var airCompressor = ""
    @Published var southAndWest240 = ""
    @Published var welder = ""
    @Published var dustCollector = ""
    @Published var wetWall = ""
    @Published var southAndWest120 = ""
    @Published var solarRoomTemperature = ""
    @Published var kitchenWestWallPlugs = ""
    @Published var kitchenSouthWallPlugs = ""
    @Published var masterBathAndPellet = ""
    @Published var masterBedroom = ""
    @Published var kateOffice = ""
    @Published var ericOffice = ""
    @Published var livingRoomPelletAndTV = ""
    @Published var stoveDishwasher = ""
    @Published var utilityRoomTemperature = ""
    
    var connected = false
    var testMode = false
	
    class func initDevice(deviceName: String, testMode: Bool = false) -> BaseDevice?
	{
		var device: BaseDevice?
		
        switch deviceName
        {
            case "MQTT":
                device = MQTTDevice()
                break

            default:
                return nil
        }

        if testMode
        {
            if let device = device
            {
                device.testMode = testMode
                device.lastPublishedTime = ""
                device.availableSolarPower = "8800"
                device.currentSolarPower = "1800"
                device.currentLoadPower = "650"
                device.batteryVoltage = "48.24"
                device.batterySOC = "100"
                device.batteryAmps = "12.00"
                device.batteryPower = "400"
                device.batteryTemperatureF = "93"
                device.batteryTemperatureC = "12"
            }
        }
		
		return device
	}
    
	func connect()
	{
	}

    func disconnect()
    {
    }

    func getTypeName() -> String
    {
        return "Undefined"
    }
    
	func getName() -> String
	{
        return "Undefined"
	}
	
    private func convertToFahrenheit(temperatureInCelsius: Float) -> Float
    {
        return temperatureInCelsius * 1.8 + 32
    }
}
