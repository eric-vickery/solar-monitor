# SolarMonitor

An iOS app that shows real-time stats for an off-grid solar system and the house it powers. Data arrives over MQTT (TLS), so the app does not talk to the inverter or energy monitor directly. Something else must publish the values to a broker.

The UI is built with SwiftUI and uses [CocoaMQTT](https://github.com/emqx/CocoaMQTT) for the broker connection. It requires iOS 17.6 or later.

## What it shows

**Solar system** (published from a Schneider Conext Combox)
- Available solar power, current solar harvest, and load
- Battery voltage, state of charge, current, power, and temperature (°C / °F)
- Charger state
- Time of the last published update

**House** (published from a Brultech GEM energy monitor)
- Per-circuit power draw, such as EV charger, well pump, shop 120 V/240 V circuits, air compressor, welder, dust collector, kitchen, offices, living room, and stove/dishwasher
- Solar room and utility room temperatures

## How it connects

- Connects to the broker on port `8883` with TLS, using the client ID `SolarMonitor`.
- Tries the **local** broker first. If it can't connect, the app falls back to the **cloud** broker.
- Auto-reconnects with a 60 second keep-alive.

### Topics

The app subscribes to these topic prefixes. The full list is in [MQTTDevice.swift](SolarMonitor/MQTTDevice.swift).

| Prefix | Content |
| --- | --- |
| `combox/` | Solar and battery values, such as `combox/totalPowerPV` and `combox/batterySOC` |
| `solarAnalyzer/` | `solarAnalyzer/availableSolarPower` |
| `dashbox/` | House circuit power and temperatures, such as `dashbox/wellPump` |

Each payload is a plain string, and the app displays it as received.

## Configuration

Nothing is hardcoded. Open the **Settings** app on the device, find **SolarMonitor**, and set:

- **Local Broker**: hostname of the broker on your network
- **Cloud Broker**: hostname of the remote broker
- **Username** and **Password**: MQTT credentials

## Building

1. Open `SolarMonitor.xcodeproj` in Xcode.
2. Let Swift Package Manager resolve CocoaMQTT.
3. Build and run on a device or simulator.

## Customizing

The topic names, circuit labels, and layout match one particular installation. To adapt the app to yours, edit the topic constants in `MQTTDevice.swift`, the matching properties in `BaseDevice.swift`, and the labels in `UI Widgets/SolarSystemUIView.swift`.

## Status

Work in progress.

## License

Released under the [MIT License](LICENSE).
