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
    static let mqttPort: UInt16 = 8883
    // Combox(Solar) topics
    static let lastPublishedTime = "combox/lastPublishedTime"
    static let availableSolarPowerTopic = "solarAnalyzer/availableSolarPower"
    static let currentSolarPowerTopic = "combox/totalPowerPV"
    static let currentLoadTopic = "combox/loadPower"
    static let batteryVoltageTopic = "combox/batteryVoltage"
    static let batterySOCTopic = "combox/batterySOC"
    static let batteryAmpsTopic = "combox/batteryCurrent"
    static let batteryPowerTopic = "combox/batteryPower"
    static let batteryTempFTopic = "combox/batteryTemperatureF"
    static let batteryTempCTopic = "combox/batteryTemperatureC"
    static let chargerStateTopic = "combox/chargerStatus"

    //Brultech(House) topics
    static let mainTopic = "dashbox/main"
    static let wellPumpTopic = "dashbox/wellPump"
    static let evChargerTopic = "dashbox/evCharger"
    static let southWallPlugTopic = "dashbox/southWallPlug"
    static let airCompressorTopic = "dashbox/airCompressor"
    static let southWest240Topic = "dashbox/southWest240Plugs"
    static let welderTopic = "dashbox/welder"
    static let dustCollectorTopic = "dashbox/dustCollector"
    static let wetWallTopic = "dashbox/wetWallPlugs"
    static let southWest120Topic = "dashbox/southWest120Plugs"
    static let solarRoomTempFTopic = "dashbox/solarRoomTempF"
    static let solarRoomTempCTopic = "dashbox/solarRoomTempC"
    static let entryTopic = "dashbox/entry"
    static let diningRoomHeaterTopic = "dashbox/diningRoomHeater"
    static let hallLightsPlugsTopic = "dashbox/hallLightsPlugs"
    static let kitchenDiningLightsTopic = "dashbox/kitchenDiningLights"
    static let kitchenWestWallPlugsTopic = "dashbox/kitchenWestWallPlugs"
    static let kitchenSouthWallPlugsTopic = "dashbox/kitchenSouthWallPlugs"
    static let washingMachineTopic = "dashbox/washingMachine"
    static let dryerTopic = "dashbox/dryer"
    static let masterBathPelletTopic = "dashbox/masterBathAndPelletStove"
    static let masterBedroomTopic = "dashbox/masterBedroom"
    static let kateOfficeTopic = "dashbox/katesOffice"
    static let ericOfficeTopic = "dashbox/ericsOffice"
    static let livingroomPelletTVTopic = "dashbox/livingRoomPelletStoveAndTV"
    static let stoveDishwasherTopic = "dashbox/stoveAndDishwasher"
    static let refrigeratorTopic = "dashbox/refrigerator"
    static let livingroomLightTopic = "dashbox/livingroomLight"
    static let utilityRoomPlugsTopic = "dashbox/utilityRoomPlugs"
    static let utilityRoomTempFTopic = "dashbox/utilityRoomTempF"
    static let utilityRoomTempCTopic = "dashbox/utilityRoomTempC"
    static let houseVoltageTopic = "dashbox/houseVoltage"

    var mqtt: CocoaMQTT?
    private var currentHost = ""
    private var connectedOnce = false

    override init()
    {
        super.init()
        let localHost = UserDefaults.standard.string(forKey: "mqtt_host_local") ?? ""
        setupMQTT(host: localHost)
    }

    private func setupMQTT(host: String)
    {
        currentHost = host
        self.mqtt = CocoaMQTT(clientID: MQTTDevice.mqttClientID, host: host, port: MQTTDevice.mqttPort)
        guard let mqtt = self.mqtt else { return }

        mqtt.keepAlive = 60
        mqtt.autoReconnect = true
        mqtt.enableSSL = true
        mqtt.sslSettings = [kCFStreamSSLPeerName as String: host as NSString]
        mqtt.username = UserDefaults.standard.string(forKey: "mqtt_username") ?? ""
        mqtt.password = UserDefaults.standard.string(forKey: "mqtt_password") ?? ""
        mqtt.didConnectAck = { _, reasonCode in
            print("CONNACK received, reason code: \(reasonCode.rawValue)")
        }
        mqtt.didDisconnect = { _, error in
            if let error = error {
                print("MQTT disconnected with error: \(error)")
            }
        }
        mqtt.didReceiveMessage = { mqtt, message, id in //, mqttDecodePublish in
            let value = message.string ?? ""
            DispatchQueue.main.async {
                switch message.topic
                {
                case MQTTDevice.lastPublishedTime:
                    self.lastPublishedTime = value
                    break

                case MQTTDevice.availableSolarPowerTopic:
                    self.availableSolarPower = value
                    break

                case MQTTDevice.currentSolarPowerTopic:
                    self.currentSolarPower = value
                    break

                case MQTTDevice.currentLoadTopic:
                    self.currentLoadPower = value
                    break

                case MQTTDevice.batteryVoltageTopic:
                    self.batteryVoltage = value
                    break

                case MQTTDevice.batterySOCTopic:
                    self.batterySOC = value
                    break

                case MQTTDevice.batteryAmpsTopic:
                    self.batteryAmps = value
                    break

                case MQTTDevice.batteryPowerTopic:
                    self.batteryPower = value
                    break

                case MQTTDevice.batteryTempFTopic:
                    self.batteryTempF = value
                    break

                case MQTTDevice.batteryTempCTopic:
                    self.batteryTempC = value
                    break

                case MQTTDevice.chargerStateTopic:
                    self.chargerState = value
                    break

                case MQTTDevice.wellPumpTopic:
                    self.wellPump = value
                    break

                case MQTTDevice.evChargerTopic:
                    self.evCharger = value
                    break

                case MQTTDevice.airCompressorTopic:
                    self.airCompressor = value
                    break

                case MQTTDevice.southWest240Topic:
                    self.southAndWest240 = value
                    break

                case MQTTDevice.welderTopic:
                    self.welder = value
                    break

                case MQTTDevice.dustCollectorTopic:
                    self.dustCollector = value
                    break

                case MQTTDevice.wetWallTopic:
                    self.wetWall = value
                    break

                case MQTTDevice.southWest120Topic:
                    self.southAndWest120 = value
                    break

                case MQTTDevice.solarRoomTempFTopic:
                    self.solarRoomTempF = value
                    break

                case MQTTDevice.solarRoomTempCTopic:
                    self.solarRoomTempC = value
                    break

                case MQTTDevice.kitchenWestWallPlugsTopic:
                    self.kitchenWestWallPlugs = value
                    break

                case MQTTDevice.kitchenSouthWallPlugsTopic:
                    self.kitchenSouthWallPlugs = value
                    break

                case MQTTDevice.masterBathPelletTopic:
                    self.masterBathAndPellet = value
                    break

                case MQTTDevice.masterBedroomTopic:
                    self.masterBedroom = value
                    break

                case MQTTDevice.kateOfficeTopic:
                    self.kateOffice = value
                    break

                case MQTTDevice.ericOfficeTopic:
                    self.ericOffice = value
                    break

                case MQTTDevice.livingroomPelletTVTopic:
                    self.livingRoomPelletAndTV = value
                    break

                case MQTTDevice.stoveDishwasherTopic:
                    self.stoveDishwasher = value
                    break

                case MQTTDevice.utilityRoomTempFTopic:
                    self.utilityRoomTempF = value
                    break

                case MQTTDevice.utilityRoomTempCTopic:
                    self.utilityRoomTempC = value
                    break

                default:
                    break
                }
            }
        }
        mqtt.didChangeState = { mqtt, connectionState in
            if connectionState == .connected
            {
                print("Connected to \(self.currentHost)")
                self.connectedOnce = true
                self.connected = true
                // Solar Topics
                mqtt.subscribe(MQTTDevice.lastPublishedTime)
                mqtt.subscribe(MQTTDevice.availableSolarPowerTopic)
                mqtt.subscribe(MQTTDevice.currentSolarPowerTopic)
                mqtt.subscribe(MQTTDevice.currentLoadTopic)
                mqtt.subscribe(MQTTDevice.batteryVoltageTopic)
                mqtt.subscribe(MQTTDevice.batterySOCTopic)
                mqtt.subscribe(MQTTDevice.batteryAmpsTopic)
                mqtt.subscribe(MQTTDevice.batteryPowerTopic)
                mqtt.subscribe(MQTTDevice.batteryTempFTopic)
                mqtt.subscribe(MQTTDevice.batteryTempCTopic)
                mqtt.subscribe(MQTTDevice.chargerStateTopic)
                // House Topics
                mqtt.subscribe(MQTTDevice.wellPumpTopic)
                mqtt.subscribe(MQTTDevice.evChargerTopic)
                mqtt.subscribe(MQTTDevice.airCompressorTopic)
                mqtt.subscribe(MQTTDevice.southWest240Topic)
                mqtt.subscribe(MQTTDevice.welderTopic)
                mqtt.subscribe(MQTTDevice.dustCollectorTopic)
                mqtt.subscribe(MQTTDevice.wetWallTopic)
                mqtt.subscribe(MQTTDevice.southWest120Topic)
                mqtt.subscribe(MQTTDevice.solarRoomTempFTopic)
                mqtt.subscribe(MQTTDevice.solarRoomTempCTopic)
                mqtt.subscribe(MQTTDevice.kitchenWestWallPlugsTopic)
                mqtt.subscribe(MQTTDevice.kitchenSouthWallPlugsTopic)
                mqtt.subscribe(MQTTDevice.masterBathPelletTopic)
                mqtt.subscribe(MQTTDevice.masterBedroomTopic)
                mqtt.subscribe(MQTTDevice.kateOfficeTopic)
                mqtt.subscribe(MQTTDevice.ericOfficeTopic)
                mqtt.subscribe(MQTTDevice.livingroomPelletTVTopic)
                mqtt.subscribe(MQTTDevice.stoveDishwasherTopic)
                mqtt.subscribe(MQTTDevice.utilityRoomTempFTopic)
                mqtt.subscribe(MQTTDevice.utilityRoomTempCTopic)
            }
            if connectionState == .connecting
            {
                print("Connecting to \(self.currentHost)")
            }
            if connectionState == .disconnected
            {
                print("Disconnected from \(self.currentHost)")
                let localHost = UserDefaults.standard.string(forKey: "mqtt_host_local") ?? ""
                if !self.connectedOnce && self.currentHost == localHost
                {
                    print("Local broker unreachable, falling back to cloud broker")
                    let cloudHost = UserDefaults.standard.string(forKey: "mqtt_host_cloud") ?? ""
                    self.setupMQTT(host: cloudHost)
                    self.connect()
                }
            }
        }
    }
    
    override func connect()
    {
        if let mqtt = mqtt
        {
            if !mqtt.connect(timeout: 10)
            {
                print("timed out connecting to broker")
            }
        }
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

