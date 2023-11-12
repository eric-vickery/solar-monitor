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
    static let batteryTempFTopic = "combox/batteryTemperature/Fahrenheit"
    static let batteryTempCTopic = "combox/batteryTemperature/Celcius"
    static let chargerStateTopic = "combox/charger/state"

    //Brultech(House) topics
    static let mainTopic = "dashbox/vickeryranch/main"
    static let wellPumpTopic = "dashbox/vickeryranch/wellPump"
    static let evChargerTopic = "dashbox/vickeryranch/evCharger"
    static let southWallPlugTopic = "dashbox/vickeryranch/southWallPlug"
    static let airCompressorTopic = "dashbox/vickeryranch/airCompressor"
    static let southWest240Topic = "dashbox/vickeryranch/southWest240"
    static let welderTopic = "dashbox/vickeryranch/welder"
    static let dustCollectorTopic = "dashbox/vickeryranch/dustCollector"
    static let wetWallTopic = "dashbox/vickeryranch/wetWall"
    static let southWest120Topic = "dashbox/vickeryranch/southWest120"
    static let solarRoomTempFTopic = "dashbox/vickeryranch/solarRoomTempF"
    static let solarRoomTempCTopic = "dashbox/vickeryranch/solarRoomTempC"
    static let entryTopic = "dashbox/vickeryranch/entry"
    static let diningRoomHeaterTopic = "dashbox/vickeryranch/diningRoomHeater"
    static let hallLightsPlugsTopic = "dashbox/vickeryranch/hallLightsPlugs"
    static let kitchenDiningLightsTopic = "dashbox/vickeryranch/kitchenDiningLights"
    static let kitchenWestWallPlugsTopic = "dashbox/vickeryranch/kitchenWestWallPlugs"
    static let kitchenSouthWallPlugsTopic = "dashbox/vickeryranch/kitchenSouthWallPlugs"
    static let washingMachineTopic = "dashbox/vickeryranch/washingMachine"
    static let dryerTopic = "dashbox/vickeryranch/dryer"
    static let masterBathPelletTopic = "dashbox/vickeryranch/masterBathPellet"
    static let masterBedroomTopic = "dashbox/vickeryranch/masterBedroom"
    static let kateOfficeTopic = "dashbox/vickeryranch/kateOffice"
    static let ericOfficeTopic = "dashbox/vickeryranch/ericOffice"
    static let livingroomPelletTVTopic = "dashbox/vickeryranch/livingroomPelletTV"
    static let stoveDishwasherTopic = "dashbox/vickeryranch/stoveDishwasher"
    static let refrigeratorTopic = "dashbox/vickeryranch/refrigerator"
    static let livingroomLightTopic = "dashbox/vickeryranch/livingroomLight"
    static let utilityRoomPlugsTopic = "dashbox/vickeryranch/utilityRoomPlugs"
    static let utilityRoomTempFTopic = "dashbox/vickeryranch/utilityRoomTempF"
    static let utilityRoomTempCTopic = "dashbox/vickeryranch/utilityRoomTempC"
    static let houseVoltageTopic = "dashbox/vickeryranch/houseVoltage"

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
                   
                case MQTTDevice.batteryTempFTopic:
                    self.batteryTempF = message.string!
                    break
                   
                case MQTTDevice.batteryTempCTopic:
                    self.batteryTempC = message.string!
                    break
                    
                case MQTTDevice.chargerStateTopic:
                    self.chargerState = message.string!
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

                case MQTTDevice.southWest240Topic:
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

                case MQTTDevice.southWest120Topic:
                    self.southAndWest120 = message.string!
                    break

                case MQTTDevice.solarRoomTempFTopic:
                    self.solarRoomTempF = message.string!
                    break

                case MQTTDevice.solarRoomTempCTopic:
                    self.solarRoomTempC = message.string!
                    break

                case MQTTDevice.kitchenWestWallPlugsTopic:
                    self.kitchenWestWallPlugs = message.string!
                    break

                case MQTTDevice.kitchenSouthWallPlugsTopic:
                    self.kitchenSouthWallPlugs = message.string!
                    break

                case MQTTDevice.masterBathPelletTopic:
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

                case MQTTDevice.livingroomPelletTVTopic:
                    self.livingRoomPelletAndTV = message.string!
                    break

                case MQTTDevice.stoveDishwasherTopic:
                    self.stoveDishwasher = message.string!
                    break

                case MQTTDevice.utilityRoomTempFTopic:
                    self.utilityRoomTempF = message.string!
                    break

                case MQTTDevice.utilityRoomTempCTopic:
                    self.utilityRoomTempC = message.string!
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
                    mqtt.subscribe(MQTTDevice.batteryTempFTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryTempCTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.chargerStateTopic, qos: CocoaMQTTQoS.qos1)
                    // House Topics
                    mqtt.subscribe(MQTTDevice.wellPumpTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.evChargerTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.airCompressorTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.southWest240Topic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.welderTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.dustCollectorTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.wetWallTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.southWest120Topic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.solarRoomTempFTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.solarRoomTempCTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.kitchenWestWallPlugsTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.kitchenSouthWallPlugsTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.masterBathPelletTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.masterBedroomTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.kateOfficeTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.ericOfficeTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.livingroomPelletTVTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.stoveDishwasherTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.utilityRoomTempFTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.utilityRoomTempCTopic, qos: CocoaMQTTQoS.qos1)
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
