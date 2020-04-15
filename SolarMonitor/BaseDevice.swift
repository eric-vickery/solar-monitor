//
//  BaseDevice.swift
//  Solar Monitor
//
//  Created by Eric Vickery
//

import Foundation
import ObjectMapper

class BaseDevice: NSObject, Mappable, ObservableObject
{
    @Published var solarPower = ""
    @Published var loadPower = ""
    @Published var batteryVoltage = ""
    @Published var batterySOC = ""
    @Published var batteryAmps = ""
    @Published var batteryPower = ""
    @Published var batteryTemperature = ""
    
	var modbus: ModBus?
	
	var deviceId: UInt8 = 0
	var registers: [String : ModbusRegister]?
    var connected = false
    var testMode = false
	
	required init?(map: Map)
	{
	}

	func mapping(map: Map)
	{
		var deviceIdString = ""

		deviceIdString	<- map["deviceId"]
		registers		<- map["registers"]

		let index = deviceIdString.index(deviceIdString.startIndex, offsetBy: 2)
		let subDeviceId = deviceIdString[index...]
		deviceId = UInt8(subDeviceId, radix: 16)!
	}
	
    class func loadFromFile(deviceName: String, testMode: Bool = false) -> BaseDevice?
	{
		var device: BaseDevice?
		
		if let path = Bundle.main.path(forResource: "DeviceFiles/" + deviceName, ofType: "json")
		{
			do {
				let jsonString = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
		
				switch deviceName
				{
					case "Combox":
						device = Combox(JSONString: jsonString)
						break
					
					case "Outback":
						device = Outback(JSONString: jsonString)
						break
					
					default:
						return nil
				}
			}
			catch let error
			{
				print(error.localizedDescription)
			}
		}
		else
		{
			print("Invalid filename/path.")
		}

        if testMode
        {
            if let device = device
            {
                device.testMode = testMode
                device.solarPower = "1800 W"
                device.loadPower = "650 W"
                device.batteryVoltage = "48.24 V"
                device.batterySOC = "100%"
                device.batteryAmps = "12.00 A"
                device.batteryPower = "400 W"
                device.batteryTemperature = "12 C / 93 F"
            }
        }
		
		return device
	}
    
    func startGettingData()
    {
        if !testMode
        {
            DispatchQueue.main.async {
                let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    self.solarPower = String(format: "%.0f W", self.getCurrentTotalPowerFromSolar() ?? 0.0)
                    self.loadPower = String(format: "%.0f W", self.getCurrentLoadPower() ?? 0.0)
                    self.batteryVoltage = String(format: "%.02f V", self.getCurrentBatteryVoltage() ?? 0.0)
                    self.batterySOC = String(format: "%.0f%%", self.getCurrentBatteryStateOfCharge() ?? 0.0)
                    self.batteryAmps = String(format: "%.02f A", self.getCurrentBatteryCurrent() ?? 0.0)
                    self.batteryPower = String(format: "%.0f W", self.getCurrentBatteryPower() ?? 0.0)
                    self.batteryTemperature = String(format: "%.0f C / %.02f F", self.getCurrentBatteryTemperature() ?? 0.0, self.convertToFahrenheit(temperatureInCelsius: self.getCurrentBatteryTemperature() ?? 0.0))
                }
            }
        }
    }
	
	func connect(address: String?, port: Int32, completionHandler: @escaping (Bool) -> Void)
	{
	}

    func getTypeName() -> String
    {
        return "Undefined"
    }
    
	func getName() -> String?
	{
        return getString("Device Name")
	}
	
	func getFirmwareVersion() -> String?
	{
        return getString("Firmware Version")
	}
	
	func getCurrentBatteryVoltage() -> Float?
	{
		return 0.0
	}
	
	func getCurrentBatteryCurrent() -> Float?
	{
		return 0.0
	}
	
	func getCurrentBatteryPower() -> Float?
	{
		return 0.0
	}
	
	func getCurrentBatteryTemperature() -> Float?
	{
		return 0.0
	}

	func getCurrentBatteryStateOfCharge() -> Float?
	{
		return 0.0
	}

	func getCurrentACOutputVoltage() -> Float?
	{
		return 0.0
	}

	func getCurrentACOutputFrequency() -> Float?
	{
		return 0.0
	}
	
	func getCurrentLoadOutputPower() -> Float?
	{
		return 0.0
	}
	
	func getCurrentLoadPower() -> Float?
	{
		return 0.0
	}
	
	func getCurrentLoadPowerApparent() -> Float?
	{
		return 0.0
	}
	
	func getCurrentPowerFromGenerator() -> Float?
	{
		return 0.0
	}

	func getCurrentGeneratorVoltage() -> Float?
	{
		return 0.0
	}
	
	func getCurrentGeneratorFrequency() -> Float?
	{
		return 0.0
	}

	func getCurrentTotalPowerFromSolar() -> Float?
	{
		return 0.0
	}

	func getCurrentHarvestPowerFromSolar() -> Float?
	{
		return 0.0
	}
	
	func getString(_ registerName: String, offset: UInt16 = 0) -> String?
	{
		if connected, let modbus = self.modbus
		{
			guard let registers = self.registers else {return nil}
			if let register = registers[registerName]
			{
				if register.type == "String"
				{
					return modbus.getString(slaveID: self.deviceId, startingRegister: register.address + offset, numRegistersToRead: register.length / 2)
				}
				else
				{
					return nil
				}
			}
		}
		return nil
	}
	
	func getFloat(_ registerName: String, offset: UInt16 = 0) -> Float?
	{
		if connected, let data = getInt(registerName, offset: offset)
		{
			guard let registers = self.registers else {return nil}
			if let register = registers[registerName]
			{
				return (Float(data) * register.scale) + register.offset
			}
		}
		return nil
	}
	
	func getInt(_ registerName: String, offset: UInt16 = 0) -> Int32?
	{
		if connected, let data = readRegisters(registerName, offset: offset)
		{
			if data.count > 0
			{
				var intValue: Int32 = 0
				
				if data.count == 2
				{
					intValue = Int32(bytesToInt16(msb: data[0], lsb: data[1]))
				}
				else
				{
					intValue = bytesToInt32(byteArray: data)
				}
				return intValue
			}
		}
		return nil
	}
	
	func getUInt32(_ registerName: String, offset: UInt16 = 0) -> UInt32?
	{
		if connected, let data = readRegisters(registerName, offset: offset)
		{
			if data.count > 0
			{
				return bytesToUInt32(byteArray: data)
			}
		}
		return nil
	}
	
	func getUInt16(_ registerName: String, offset: UInt16 = 0) -> UInt16?
	{
		if connected, let data = readRegisters(registerName, offset: offset)
		{
			if data.count > 0
			{
				return bytesToUInt16(msb: data[0], lsb: data[1])
			}
		}
		return nil
	}
	
	func getBoolean(_ registerName: String, offset: UInt16 = 0) -> Bool?
	{
		if connected, let data = readRegisters(registerName, offset: offset)
		{
			if data.count == 2
			{
				return data[1] != 0
			}
		}
		return nil
	}
	
	func readRegisters(_ registerName: String, offset: UInt16 = 0) -> [UInt8]?
	{
		if let modbus = self.modbus
		{
			guard let registers = self.registers else {return nil}
			if let register = registers[registerName]
			{
				return modbus.readRegisters(slaveID: self.deviceId, startingRegister: register.address + offset, numRegistersToRead: register.length)
			}
		}
		return nil
	}
	
	func bytesToUInt16(msb: UInt8, lsb: UInt8) -> UInt16
	{
		return UInt16(UInt16(msb) << 8 | UInt16(lsb))
	}
	
	func bytesToInt16(msb: UInt8, lsb: UInt8) -> Int16
	{
		return Int16(Int16(msb) << 8 | Int16(lsb))
	}
	
	func bytesToUInt32(byteArray: [UInt8]) -> UInt32
	{
		return UInt32(bytesToUInt(byteArray: byteArray))
	}
	
	func bytesToInt32(byteArray: [UInt8]) -> Int32
	{
		return Int32(bitPattern: bytesToUInt(byteArray: byteArray))
	}
	
	func bytesToUInt(byteArray: [UInt8]) -> UInt32
	{
		assert(byteArray.count <= 4)
		
		var result: UInt32 = 0
		
		for idx in 0..<(byteArray.count)
		{
			let shiftAmount = UInt((byteArray.count) - idx - 1) * 8
			result += UInt32(byteArray[idx]) << shiftAmount
		}
		return result
	}
    
    private func convertToFahrenheit(temperatureInCelsius: Float) -> Float
    {
        return temperatureInCelsius * 1.8 + 32
    }
}
