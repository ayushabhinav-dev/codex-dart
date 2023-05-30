# D.A.R.T - Direct Automotive Receiver & Transmitter

D.A.R.T (Direct Automotive Receiver & Transmitter) is a FiveM resource that allows police officers in emergency vehicles to track suspects by firing tracking darts at their vehicles. The tracking darts create blips on the map that update every minute, providing real-time location information to the emergency vehicle operators.

## Features

- Police officers in emergency vehicles can fire tracking darts at nearby vehicles.

- Tracking darts create blips on the map that update every minute.

- Tracking darts remain active for 30 minutes.

- The tracking darts can be canceled by using the `/stopdart` command.

- Customizable cooldown duration and distance limit for firing darts.

- Ability to add custom sound events for firing and removing darts.

- Exports available for integration with other resources.

## Getting Started

### Prerequisites

- [FiveM](https://fivem.net/) server with appropriate permissions to install resources.

### Installation

1. Clone or download this repository.

2. Rename the folder to `darttracker` (optional).

3. Place the `darttracker` folder in the `resources` directory of your FiveM server.

4. Add the following line to your server.cfg file:

   ```

   start darttracker

   ```

### Usage

- Police officers in emergency vehicles can type `/dart` to fire a tracking dart at a nearby vehicle.

- The tracking dart will stay attached to the targeted vehicle for 30 minutes.

- The blip on the map showing the vehicle's location updates every minute.

- To cancel a tracking dart, type `/stopdart` in an emergency vehicle.

### Customization

- You can customize the cooldown duration and distance limit for firing darts by modifying the `dartCooldownDuration` and `dartDistanceLimit` variables in the `server.lua` file.

- To add custom sound events, modify the script and add your own sound event triggers.

### Exports

The following exports are available for integration with other resources:

- `StartDart(source, target)`: Starts tracking a specified target player's vehicle with a dart.

- `StopDart(source, target)`: Stops tracking a specified target player's vehicle.

To use these exports, you can use the following syntax in your Lua script:

```lua

exports['darttracker']:StartDart(source, target)

exports['darttracker']:StopDart(source, target)

```

## Credits

- Developed by [TheStoicBear](https://github.com/TheStoicBear)

## License

This resource is licensed under the [MIT License](LICENSE).
