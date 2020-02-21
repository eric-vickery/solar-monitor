//
//  ViewController.swift
//  SolarMonitor
//
//  Created by Eric Vickery
//

import UIKit

class ViewController: UIViewController
{

	@IBOutlet weak var comboxSolarText: UILabel!
	@IBOutlet weak var comboxLoadText: UILabel!
	@IBOutlet weak var comboxVoltageText: UILabel!
	@IBOutlet weak var comboxBatterySOCText: UILabel!
	@IBOutlet weak var comboxBatteryAmpsText: UILabel!
	@IBOutlet weak var comboxBatteryPowerText: UILabel!
	@IBOutlet weak var comboxBatteryTemperatureText: UILabel!

	@IBOutlet weak var outbackSolarText: UILabel!
	@IBOutlet weak var outbackLoadText: UILabel!
	@IBOutlet weak var outbackVoltageText: UILabel!
	@IBOutlet weak var outbackBatterySOCText: UILabel!
	@IBOutlet weak var outbackBatteryAmpsText: UILabel!
	@IBOutlet weak var outbackBatteryPowerText: UILabel!
	@IBOutlet weak var outbackBatteryTemperatureText: UILabel!
	
	var comboxSolarPower: Float = 0.0
	var comboxLoadPower: Float = 0.0
	var comboxBatteryVoltage: Float = 0.0
	var comboxBatterySOC: Float = 0.0
	var comboxBatteryAmps: Float = 0.0
	var comboxBatteryPower: Float = 0.0
	var comboxBatteryTemperature: Float = 0.0
	var combox: Combox?
	var comboxConnected = false

	var outbackSolarPower: Float = 0.0
	var outbackLoadPower: Float = 0.0
	var outbackBatteryVoltage: Float = 0.0
	var outbackBatterySOC: Float = 0.0
	var outbackBatteryAmps: Float = 0.0
	var outbackBatteryPower: Float = 0.0
	var outbackBatteryTemperature: Float = 0.0
	var outback: Outback?
	var outbackConnected = false

	override func viewDidLoad()
	{
		super.viewDidLoad()

		// TODO TEST CODE> REMOVE LATER
//		let brultech = Brultech()
//		brultech.refreshStatesFromHardware()
//		let channel = 2220
//		brultech.getDailyUsage(channelID: channel) { usage in
//			print("Daily usage for channel \(channel) = \(usage)")
//		}
		
		updateUI()

		connectToCombox()
		
		connectToOutback()

		let timer = Timer(timeInterval: 1.5, repeats: true) { timer in
			// Get the current combox values
			if self.comboxConnected
			{
				self.comboxSolarPower = self.combox?.getCurrentTotalPowerFromSolar() ?? 0.0
				self.comboxLoadPower = self.combox?.getCurrentLoadPower() ?? 0.0
				self.comboxBatteryVoltage = self.combox?.getCurrentBatteryVoltage() ?? 0.0
				self.comboxBatterySOC = self.combox?.getCurrentBatteryStateOfCharge() ?? 0.0
				self.comboxBatteryAmps = self.combox?.getCurrentBatteryCurrent() ?? 0.0
				self.comboxBatteryPower = self.combox?.getCurrentBatteryPower() ?? 0.0
				self.comboxBatteryTemperature = self.combox?.getCurrentBatteryTemperature() ?? 0.0
			}
			
			// Get the current outback values
			if self.outbackConnected
			{
				self.outbackSolarPower = self.outback?.getCurrentTotalPowerFromSolar() ?? 0.0
				self.outbackLoadPower = self.outback?.getCurrentLoadPower() ?? 0.0
				self.outbackBatteryVoltage = self.outback?.getCurrentBatteryVoltage() ?? 0.0
				self.outbackBatterySOC = self.outback?.getCurrentBatteryStateOfCharge() ?? 0.0
				self.outbackBatteryAmps = self.outback?.getCurrentBatteryCurrent() ?? 0.0
				self.outbackBatteryPower = self.outback?.getCurrentBatteryPower() ?? 0.0
				self.outbackBatteryTemperature = self.outback?.getCurrentBatteryTemperature() ?? 0.0
			}
			
			DispatchQueue.main.async { [weak self] in
				self?.updateUI()
			}
		}
		RunLoop.current.add(timer, forMode: .common)
	}
	
	func connectToOutback()
	{
		DispatchQueue.global(qos: .userInitiated).async { [weak self] in
			guard let self = self else { return }
			
			self.outback = BaseDevice.loadFromFile(deviceName: "Outback") as? Outback
			self.outback?.connect(address: "192.168.211.11", port: 502, completionHandler: { result in
				if result
				{
					self.outbackConnected = true
				}
				else
				{
					// There was an error loading try again
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
						self?.connectToOutback()
					}
				}
			})
		}
	}
	
	func connectToCombox()
	{
		DispatchQueue.global(qos: .userInitiated).async { [weak self] in
			guard let self = self else { return }
			
			self.combox = BaseDevice.loadFromFile(deviceName: "Combox") as? Combox
			self.combox?.connect(address: "192.168.211.10", port: 502, completionHandler: { result in
				if result
				{
					self.comboxConnected = true
				}
				else
				{
					// There was an error loading try again
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
						self?.connectToCombox()
					}
				}
			})
		}
	}
	
	func updateUI()
	{
		// Update the UI to the current values
		self.comboxSolarText.text = self.comboxBatteryVoltage > 0 ? String(format: "%.0f W", self.comboxSolarPower) : ""
		self.comboxLoadText.text = self.comboxBatteryVoltage > 0 ? String(format: "%.0f W", self.comboxLoadPower) : ""
		self.comboxVoltageText.text = self.comboxBatteryVoltage > 0 ? String(format: "%.02f V", self.comboxBatteryVoltage) : ""
		self.comboxBatterySOCText.text = self.comboxBatteryVoltage > 0 ? String(format: "%.0f%%", self.comboxBatterySOC) : ""
		self.comboxBatteryAmpsText.text = self.comboxBatteryVoltage > 0 ? String(format: "%.02f A", self.comboxBatteryAmps) : ""
		self.comboxBatteryPowerText.text = self.comboxBatteryVoltage > 0 ? String(format: "%.0f W", self.comboxBatteryPower) : ""
		self.comboxBatteryTemperatureText.text = self.comboxBatteryVoltage > 0 ? String(format: "%.0f C / %.02f F", self.comboxBatteryTemperature, convertToFahrenheit(temperatureInCelsius: self.comboxBatteryTemperature)) : ""

		self.outbackSolarText.text = self.outbackBatteryVoltage > 0 ? String(format: "%.0f W", self.outbackSolarPower) : ""
		self.outbackLoadText.text = self.outbackBatteryVoltage > 0 ? String(format: "%.0f W", self.outbackLoadPower) : ""
		self.outbackVoltageText.text = self.outbackBatteryVoltage > 0 ? String(format: "%.02f V", self.outbackBatteryVoltage) : ""
		self.outbackBatterySOCText.text = self.outbackBatteryVoltage > 0 ? String(format: "%.0f%%", self.outbackBatterySOC) : ""
		self.outbackBatteryAmpsText.text = self.outbackBatteryVoltage > 0 ? String(format: "%.02f A", self.outbackBatteryAmps) : ""
		self.outbackBatteryPowerText.text = self.outbackBatteryVoltage > 0 ? String(format: "%.0f W", self.outbackBatteryPower) : ""
		self.outbackBatteryTemperatureText.text = self.outbackBatteryVoltage > 0 ? String(format: "%.0f C / %.02f F", self.outbackBatteryTemperature, convertToFahrenheit(temperatureInCelsius: self.outbackBatteryTemperature)) : ""
	}
	
	private func convertToFahrenheit(temperatureInCelsius: Float) -> Float
	{
		return temperatureInCelsius * 1.8 + 32
	}
}

