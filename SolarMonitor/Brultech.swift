//
//  Brultech.swift
//  SolarMonitor
//
//  Created by Eric Vickery
//

import Foundation
import Alamofire
//import AlamofireObjectMapper

// TODO Move the host to a setting instead of it being hard coded
class Brultech
{
	let host = "dashbox.vickeryranch.com"
	var indexedPowerData = [Int: Float]()

	func findAllDevices()
	{
		
	}
	//def addIndigoDevices(self, valuesDict, deviceIdList):
	//# First remove all the devices we have added
	//self.removeAllDevices(valuesDict, deviceIdList)
	//
	//# Now go find all the active channels on the Dashbox and add them
	//hostName = self.pluginPrefs["address"]
	//dbPassword = self.pluginPrefs["password"]
	//if hostName is None or hostName == "" or dbPassword is None or dbPassword == "":
	//return
	//
	//	parser = HTMLParser()
	//conn = pg8000.connect(user="dbbackup", password=dbPassword, database="brultech_dash", host=hostName)
	//cursor = conn.cursor()
	//cursor.execute("SELECT channel_id, channel_name, pulse_unit, chnum, ctype, devices.device_id, netchannel_id FROM channel INNER JOIN devices ON channel.device_id = devices.device_id WHERE hide = 0 ORDER BY channel_id ASC")
	//results = cursor.fetchall()
	//device_dict = {}
	//for row in results:
	//channel_id, channel_name, pulse_unit, chnum, ctype, device_id, netchannel_id = row
	//deviceType = kChannelTypeToDeviceType[ctype]
	//
	//newdev = indigo.device.create(indigo.kProtocol.Plugin, deviceTypeId=deviceType)
	//newdev.model = "Dashbox Channel"
	//newdev.subModel = parser.unescape(channel_name)
	//newdev.name = parser.unescape(channel_name)
	//newdev.remoteDisplay = True
	//newdev.replaceOnServer()
	//
	//device_dict["channelId"] = channel_id
	//device_dict["channelName"] = parser.unescape(channel_name)
	//device_dict["pulseUnit"] = pulse_unit
	//device_dict["channelNumber"] = chnum
	//device_dict["channelType"] = ctype
	//device_dict["deviceId"] = device_id
	//device_dict["netchannelId"] = netchannel_id
	//if deviceType == kTemperatureDevice or deviceType == kVoltageDevice or deviceType == kPulseSensorDevice:
	//device_dict["SupportsOnState"] = False
	//device_dict["SupportsSensorValue"] = True
	//device_dict["SupportsStatusRequest"] = False
	//device_dict["AllowOnStateChange"] = False
	//device_dict["AllowSensorValueChange"] = False
	//else:
	//device_dict["SupportsEnergyMeter"] = True
	//device_dict["SupportsEnergyMeterCurPower"] = True
	//device_dict["SupportsSensorValue"] = True
	//device_dict["SupportsStatusRequest"] = False
	//device_dict["AllowSensorValueChange"] = False
	//newdev.replacePluginPropsOnServer(device_dict)
	//
	//cursor.close()
	//conn.close()
	//
	//return valuesDict
	
//	func refreshStatesFromHardware()
//	{
//		var indexedPowerData: [Int: Float] = [Int: Float]()
//		
//		var URL = "http://\(self.host)/index.php/pages/search/all/0"
//		Alamofire.request(URL).responseObject { (response: DataResponse<BrultechChannels>) in
//			if response.error != nil
//			{
//				return
//			}
//			
//			if let activeChannels = response.result.value?.channelList
//			{
//				URL = "http://\(self.host)/index.php/pages/search/getWattVals"
//				Alamofire.request(URL).responseJSON { (response) in
//					if response.error != nil
//					{
//						return
//					}
//
//					if let deviceList = response.result.value as? [String:[String:[String]]]
//					{
//						var index = 0
//						for deviceInfo in deviceList.values
//						{
//							if let wattValues = deviceInfo["watts"]
//							{
//								for item in wattValues
//								{
//									indexedPowerData[activeChannels[index]] = Float(item)
//									index += 1
//								}
//							}
//						}
//						self.indexedPowerData = indexedPowerData
//					}
//				}
//			}
//		}
//	}
//
//	func getDailyUsage(channelID: Int, completionHandler: @escaping (Float) -> Void)
//	{
//		var dailyConsumption: Float = 0.0
//		
//		let parameters: [String: String] = [
//			"chans" : "\(channelID), -1, -1"
//		]
//		Alamofire.request("http://\(self.host)/index.php/pages/load/loadBarGraph", method: .post, parameters: parameters, encoding: URLEncoding.default)
//			.responseJSON { (response) in
//				if response.error != nil
//				{
//					completionHandler(0.0)
//					return
//				}
//				
//				if let hourlyConsumptionArray = response.result.value as? [[String: Any]]
//				{
//					var channelName: String?
//					
//					for hourlyConsumption in hourlyConsumptionArray
//					{
//						if channelName == nil
//						{
//							let keys = hourlyConsumption.keys
//							for key in keys
//							{
//								if key != "date"
//								{
//									channelName = key
//								}
//							}
//						}
//						
//						if let deviceName = channelName, let consumption = hourlyConsumption[deviceName] as? Double
//						{
//							dailyConsumption += Float(consumption)
//						}
//					}
//					completionHandler(dailyConsumption)
//				}
//		}
//		return
//	}

}
//kOnlineState = "online"
//kOfflineState = "offline"
//
//kChannelId = "channelId"
//kChannelName = "channelName"
//kPulseUnit = "pulseUnit"
//kChannelNumber = "channelNumber"
//kChannelType = "channelType"
//kDeviceId = "deviceId"
//kNetchannelId = "netchannelId"
//
//
//kPowerMeterDevice = "powerMeterDevice"
//kTemperatureDevice = "temperatureSensorDevice"
//kPulseSensorDevice = "pulseSensorDevice"
//kVoltageDevice = "voltageSensorDevice"
//
//kChannelTypeToDeviceType = {
//	0: kPowerMeterDevice,
//	1: kTemperatureDevice,
//	2: kPulseSensorDevice,
//	3: kVoltageDevice
//}


//def refreshDeviceFromData(self, dev, powerData, logRefresh):
//
//keyValueList = []
//
//try:
//if dev.deviceTypeId == kTemperatureDevice:
//if dev.sensorValue is not None:
//exampleTempFloat = float(powerData[dev.pluginProps[kChannelId]])
//exampleTempStr = "%.1f °F" % (exampleTempFloat)
//
//keyValueList.append({'key': 'sensorValue', 'value': exampleTempFloat, 'uiValue': exampleTempStr})
//dev.updateStateImageOnServer(indigo.kStateImageSel.TemperatureSensor)
//
//elif dev.deviceTypeId == kVoltageDevice:
//	if dev.sensorValue is not None:
//exampleTempFloat = float(powerData[dev.pluginProps[kChannelId]])
//exampleTempStr = "%.1f V" % (exampleTempFloat)
//
//keyValueList.append({'key': 'sensorValue', 'value': exampleTempFloat, 'uiValue': exampleTempStr})
//
//elif dev.deviceTypeId == kPulseSensorDevice:
//	if dev.sensorValue is not None:
//exampleTemp = int(powerData[dev.pluginProps[kChannelId]])
//exampleTempStr = "%d Pulses" % (exampleTemp)
//
//keyValueList.append({'key': 'sensorValue', 'value': exampleTemp, 'uiValue': exampleTempStr})
//
//elif dev.deviceTypeId == kPowerMeterDevice:
//	if "curEnergyLevel" in dev.states:
//watts = int(powerData[dev.pluginProps[kChannelId]])
//wattsStr = "%d W" % (watts)
//if logRefresh:
//indigo.server.log(u"received \"%s\" %s to %s" % (dev.name, "power load", wattsStr))
//keyValueList.append({'key': 'curEnergyLevel', 'value': watts, 'uiValue': wattsStr})
//
//if "accumEnergyTotal" in dev.states:
//dailyKwh = self.getDailyUsage(dev.pluginProps[kChannelId])
//dailyKwhStr = "%.3f kWh" % (dailyKwh)
//if logRefresh:
//indigo.server.log(u"received \"%s\" %s to %s" % (dev.name, "energy total", dailyKwhStr))
//keyValueList.append({'key': 'accumEnergyTotal', 'value': dailyKwh, 'uiValue': dailyKwhStr})
//
//dev.updateStatesOnServer(keyValueList)
//except (KeyError, TypeError):
//pass



//def runConcurrentThread(self):
//try:
//while True:
//powerData = self.refreshStatesFromHardware(False)
//for dev in indigo.devices.iter("self"):
//if not dev.enabled or not dev.configured:
//indigo.server.log(u"Device not enabled")
//continue
//
//self.refreshDeviceFromData(dev, powerData, False)
//
//self.sleep(4)
//except self.StopThread:
//pass  # Optionally catch the StopThread exception and do any needed cleanup.



//def getDeviceGroupList(self, filter, valuesDict, deviceIdList):
//device_list = []
//
//for deviceId in deviceIdList:
//if deviceId in indigo.devices:
//indigoDevice = indigo.devices[deviceId]
//
//deviceName = indigoDevice.name
//else:
//deviceName = u"- device not found -"
//
//device_list.append((deviceId, deviceName))
//
//return device_list



//def addIndigoDevices(self, valuesDict, deviceIdList):
//# First remove all the devices we have added
//self.removeAllDevices(valuesDict, deviceIdList)
//
//# Now go find all the active channels on the Dashbox and add them
//hostName = self.pluginPrefs["address"]
//dbPassword = self.pluginPrefs["password"]
//if hostName is None or hostName == "" or dbPassword is None or dbPassword == "":
//return
//
//	parser = HTMLParser()
//conn = pg8000.connect(user="dbbackup", password=dbPassword, database="brultech_dash", host=hostName)
//cursor = conn.cursor()
//cursor.execute("SELECT channel_id, channel_name, pulse_unit, chnum, ctype, devices.device_id, netchannel_id FROM channel INNER JOIN devices ON channel.device_id = devices.device_id WHERE hide = 0 ORDER BY channel_id ASC")
//results = cursor.fetchall()
//device_dict = {}
//for row in results:
//channel_id, channel_name, pulse_unit, chnum, ctype, device_id, netchannel_id = row
//deviceType = kChannelTypeToDeviceType[ctype]
//
//newdev = indigo.device.create(indigo.kProtocol.Plugin, deviceTypeId=deviceType)
//newdev.model = "Dashbox Channel"
//newdev.subModel = parser.unescape(channel_name)
//newdev.name = parser.unescape(channel_name)
//newdev.remoteDisplay = True
//newdev.replaceOnServer()
//
//device_dict["channelId"] = channel_id
//device_dict["channelName"] = parser.unescape(channel_name)
//device_dict["pulseUnit"] = pulse_unit
//device_dict["channelNumber"] = chnum
//device_dict["channelType"] = ctype
//device_dict["deviceId"] = device_id
//device_dict["netchannelId"] = netchannel_id
//if deviceType == kTemperatureDevice or deviceType == kVoltageDevice or deviceType == kPulseSensorDevice:
//device_dict["SupportsOnState"] = False
//device_dict["SupportsSensorValue"] = True
//device_dict["SupportsStatusRequest"] = False
//device_dict["AllowOnStateChange"] = False
//device_dict["AllowSensorValueChange"] = False
//else:
//device_dict["SupportsEnergyMeter"] = True
//device_dict["SupportsEnergyMeterCurPower"] = True
//device_dict["SupportsSensorValue"] = True
//device_dict["SupportsStatusRequest"] = False
//device_dict["AllowSensorValueChange"] = False
//newdev.replacePluginPropsOnServer(device_dict)
//
//cursor.close()
//conn.close()
//
//return valuesDict



//def removeAllDevices(self, valuesDict, devIdList):
//for devId in devIdList:
//try:
//indigo.device.delete(devId)
//except:
//pass  # delete doesn't allow (throws) on root elem
//return valuesDict
