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
    static let availableSolarPowerTopic = "combox/availableSolar"
    static let currentSolarPowerTopic = "combox/currentSolar"
    static let currentLoadTopic = "combox/currentLoad"
    static let batteryVoltageTopic = "combox/batteryVoltage"
    static let batterySOCTopic = "combox/batterySOC"
    static let batteryAmpsTopic = "combox/batteryAmps"
    static let batteryPowerTopic = "combox/batteryPower"
    static let batteryTemperatureFTopic = "combox/batteryTemperature/Fahrenheit"
    static let batteryTemperatureCTopic = "combox/batteryTemperature/Celcius"

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
                case MQTTDevice.availableSolarPowerTopic:
                    self.availableSolarPower = message.string!
                    break;
                    
                case MQTTDevice.currentSolarPowerTopic:
                    self.currentSolarPower = message.string!
                    break;
                   
                case MQTTDevice.currentLoadTopic:
                    self.currentLoadPower = message.string!
                    break;
                   
                case MQTTDevice.batteryVoltageTopic:
                    self.batteryVoltage = message.string!
                    break;
                   
                case MQTTDevice.batterySOCTopic:
                    self.batterySOC = message.string!
                    break;
                   
                case MQTTDevice.batteryAmpsTopic:
                    self.batteryAmps = message.string!
                    break;
                   
                case MQTTDevice.batteryPowerTopic:
                    self.batteryPower = message.string!
                    break;
                   
                case MQTTDevice.batteryTemperatureFTopic:
                    self.batteryTemperatureF = message.string!
                    break;
                   
                case MQTTDevice.batteryTemperatureCTopic:
                    self.batteryTemperatureC = message.string!
                    break;
                   
                default:
                    break;
                }
            }
            mqtt.didChangeState = { mqtt, connectionState in
                if connectionState == .connected
                {
                    self.connected = true
                    mqtt.subscribe(MQTTDevice.availableSolarPowerTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.currentSolarPowerTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.currentLoadTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryVoltageTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batterySOCTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryAmpsTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryPowerTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryTemperatureFTopic, qos: CocoaMQTTQoS.qos1)
                    mqtt.subscribe(MQTTDevice.batteryTemperatureCTopic, qos: CocoaMQTTQoS.qos1)
//                    print("Connected")
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
