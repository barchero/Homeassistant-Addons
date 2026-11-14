# Barista

Bridge between your De'Longhi ECAM coffee machine (Bluetooth LE) and HTTP.
It exposes a Web UI (in the Home Assistant sidebar) and a REST API on port `8080`.

## Requirements

- A Bluetooth adapter available to Home Assistant (built-in on Raspberry Pi).
- The De'Longhi Coffee Link app must be **disconnected** — the machine accepts only one BLE connection.

## Installation

Home Assistant builds the add-on image locally on install (it downloads the
barista source from GitHub), so the first installation and every update can
take a few minutes, especially on a Raspberry Pi.

## Configuration

| Option                                         | Description                                                 |
|------------------------------------------------|-------------------------------------------------------------|
| **Coffee machine Bluetooth address** (`address`) | Bluetooth (BLE) MAC address of the machine, e.g. `00:A0:50:XX:XX:XX`. |
| **Log level** (`log_level`)                    | Amount of detail written to the add-on log.                 |

**Finding the address:** start the add-on with the Bluetooth address empty. It scans for
nearby machines, prints the addresses in the log and stops. Copy the address
into the configuration and start it again.

## Usage

- Web UI: **Barista** entry in the Home Assistant sidebar (enable "Show in sidebar"
  on the add-on page), or "Open Web UI". Also reachable at `http://<home-assistant-ip>:8080`.
- API, e.g. brew a coffee from a Home Assistant `rest_command`:

```yaml
rest_command:
  brew_coffee:
    url: "http://localhost:8080/api/brew"
    method: POST
    content_type: "application/json"
    payload: '{"beverage":"coffee"}'
```

Auto-brew schedules are stored in the add-on's persistent `/data` folder.
