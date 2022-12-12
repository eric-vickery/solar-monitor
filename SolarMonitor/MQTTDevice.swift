//
//  MqttDevice.swift
//  SolarMonitor
//
//  Created by Eric Vickery on 12/10/22.
//  Copyright © 2022 Eric Vickery. All rights reserved.
//

import Foundation
import CocoaMQTT

class MQTTDevice: BaseDevice
{
    static let mqttClientID = "SolarMonitor"
    static let mqttHost = "192.168.211.1"
    static let mqttPort: UInt16 = 1883
    // Combox(Solar) topics
    static let lastPublishedTime = "combox/lastPublishedTime"
    static let availableSolarPowerTopic = "combox/availableSolar"
    static let currentSolarPowerTopic = "combox/currentSolar"
    static let currentLoadTopic = "combox/currentLoad"
    static let batteryVoltageTopic = "combox/batteryVoltage"
    static let batterySOCTopic = "combox/batterySOC"
    static let batteryAmpsTopic = "combox/batteryAmps"
    static let batteryPowerTopic = "combox/batteryPower"
    static let batteryTemperatureFTopic = "combox/batteryTemperature/Fahrenheit"
    static let batteryTemperatureCTopic = "combox/batteryTemperature/Celcius"
    //Brultech(House) topics
    static let wellPumpTopic = "dashbox/01001232/c2/watt"
    static let evChargerTopic = "dashbox/01001232/c4/watt"
    static let airCompressorTopic = "dashbox/01001232/c7/watt"
    static let southAndWest240Topic = "dashbox/01001232/c8/watt"
    static let welderTopic = "dashbox/01001232/c9/watt"
    static let dustCollectorTopic = "dashbox/01001232/c10/watt"
    static let wetWallTopic = "dashbox/01001232/c11/watt"
    static let southAndWest120Topic = "dashbox/01001232/c12/watt"
    static let solarRoomTemperatureTopic = "dashbox/01001232/t1/val"
    static let kitchenWestWallPlugsTopic = "dashbox/01100599/c7/watt"
    static let kitchenSouthWallPlugsTopic = "dashbox/01100599/c8/watt"
    static let masterBathAndPelletTopic = "dashbox/01100599/c11/watt"
    static let masterBedroomTopic = "dashbox/01100599/c12/watt"
    static let kateOfficeTopic = "dashbox/01100599/c13/watt"
    static let ericOfficeTopic = "dashbox/01100599/c14/watt"
    static let livingRoomPelletAndTVTopic = "dashbox/01100599/c15/watt"
    static let stoveDishwasherTopic = "dashbox/01100599/c16/watt"
    static let utilityRoomTemperatureTopic = "dashbox/01100599/t1/val"

    var mqtt: CocoaMQTT?

    override init()
    {
        super.init()
        self.mqtt = CocoaMQTT(clientID: MQTTDevice.mqttClientID, host: MQTTDevice.mqttHost, port: MQTTDevice.mqttPort)
        if let mqtt = self.mqtt
        {
            mqtt.allowUntrustCACertificate = true
            mqtt.keepAlive = 60
            mqtt.didReceiveMessage = { mqtt, message, id in
                switch message.topic
                {
                case MQTTDevice.lastPublishedTime:
                    self.lastPublishedTime = message.string!
                    break
                    
                case MQTTDevice.availableSolarPowerTopic:
                    self.availableSolarPower = message.string!
                    break
                    
                case MQTTDevice.currentSolarPowerTopic:
                    self.currentSolarPower = message.string!
                    break
                   
                case MQTTDevice.currentLoadTopic:
                    self.currentLoadPower = message.string!
                    break
                   
                case MQTTDevice.batteryVoltageTopic:
                    self.batteryVoltage = message.string!
                    break
                   
                case MQTTDevice.batterySOCTopic:
                    self.batterySOC = message.string!
                    break
                   
                case MQTTDevice.batteryAmpsTopic:
                    self.batteryAmps = message.string!
                    break
                   
                case MQTTDevice.batteryPowerTopic:
                    self.batteryPower = message.string!
                    break
                   
                case MQTTDevice.batteryTemperatureFTopic:
                    self.batteryTemperatureF = message.string!
                    break
                   
                case MQTTDevice.batteryTemperatureCTopic:
                    self.batteryTemperatureC = message.string!
                    break

                case MQTTDevice.wellPumpTopic:
                    self.wellPump = message.string!
                    break

                case MQTTDevice.evChargerTopic:
                    self.evCharger = message.string!
                    break

                case MQTTDevice.airCompressorTopic:
                    self.airCompressor = message.string!
                    break

                case MQTTDevice.southAndWest240Topic:
                    self.southAndWest240 = message.string!
                    break

                case MQTTDevice.welderTopic:
                    self.welder = message.string!
                    break
                    
                case MQTTDevice.dustCollectorTopic:
                    self.dustCollector = message.string!
                    break

                case MQTTDevice.wetWallTopic:
                    self.wetWall = message.string!
                    break

                case MQTTDevice.southAndWest120Topic:
                    self.southAndWest120 = message.string!
                    break

                case MQTTDevice.solarRoomTemperatureTopic:
                    self.solarRoomTemperature = message.string!
                    break

                case MQTTDevice.kitchenWestWallPlugsTopic:
                    self.kitchenWestWallPlugs = message.string!
                    break

                case MQTTDevice.kitchenSouthWallPlugsTopic:
                    self.kitchenSouthWallPlugs = message.string!
                    break

                case MQTTDevice.masterBathAndPelletTopic:
                    self.masterBathAndPellet = message.string!
                    break

                case MQTTDevice.masterBedroomTopic:
                    self.masterBedroom = message.string!
                    break

                case MQTTDevice.kateOfficeTopic:
                    self.kateOffice = message.string!
                    break

                case MQTTDevice.ericOfficeTopic:
                    self.ericOffice = message.string!
                    break

                case MQTTDevice.livingRoomPelletAndTVTopic:
                    self.livingRoomPelletAndTV = message.string!
                    break

                case MQTTDevice.stoveDishwasherTopic:
                    self.stoveDishwasher = message.string!
                    break

                case MQTTDevice.utilityRoomTemperatureTopic:
                    self.utilityRoomTemperature = message.string!
                    break

                default:
                    break
                }
            }
            mqtt.didChangeState = { mqtt, connectionState in
                if connectionState == .connected
                {
                    self.connected = true
                    // Solar Topics
                    mqtt.subscribe(MQTTDevice.lastPublishedTime, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.availableSolarPowerTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.currentSolarPowerTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.currentLoadTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryVoltageTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batterySOCTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryAmpsTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryPowerTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryTemperatureFTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryTemperatureCTopic, qos: CocoaMQTTQoS.qos1)
                    // House Topics
                    mqtt.subscribe(MQTTDevice.wellPumpTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.evChargerTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.airCompressorTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.southAndWest240Topic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.welderTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.dustCollectorTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.wetWallTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.southAndWest120Topic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.solarRoomTemperatureTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.kitchenWestWallPlugsTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.kitchenSouthWallPlugsTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.masterBathAndPelletTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.masterBedroomTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.kateOfficeTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.ericOfficeTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.livingRoomPelletAndTVTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.stoveDishwasherTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.utilityRoomTemperatureTopic, qos: CocoaMQTTQoS.qos1)
                }
            }
        }
    }
    
    override func connect()
    {
        _ = mqtt?.connect()
    }

    override func disconnect()
    {
        _ = mqtt?.disconnect()
        connected = false
    }

    override func getTypeName() -> String
    {
        return "MQTT"
    }
    
    override func getName() -> String
    {
        return "Solar"
    }
}
