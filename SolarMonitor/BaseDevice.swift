//
//  BaseDevice.swift
//  Solar Monitor
//
//  Created by Eric Vickery
//

import Foundation
import ObjectMapper
import CocoaMQTT

class BaseDevice: NSObject, ObservableObject
{
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
