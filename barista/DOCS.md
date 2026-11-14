# Barista

Bridge between your De'Longhi ECAM coffee machine (Bluetooth LE) and HTTP.
It exposes a Web UI and a REST API on the configured port (default `8080`).

## Requirements

- A Bluetooth adapter available to Home Assistant (built-in on Raspberry Pi).
- The De'Longhi Coffee Link app must be **disconnected** — the machine accepts only one BLE connection.

## Installation

Home Assistant builds the add-on image locally on install (it downloads the
barista source from GitHub), so the first installation and every update can
take a few minutes, especially on a Raspberry Pi.

## Configuration

| Option      | Description                                                      |
|-------------|------------------------------------------------------------------|
| `address`   | BLE address of the machine, e.g. `00:A0:50:2A:D2:8F`.            |
| `port`      | HTTP port for the Web UI / API (default `8080`).                 |
| `log_level` | Log level of the add-on.                                         |

**Finding the address:** start the add-on with `address` empty. It scans for
nearby machines, prints the addresses in the log and stops. Copy the address
into the configuration and start it again.

## Usage

- Web UI: `http://<home-assistant-ip>:8080` (or "Open Web UI" in the add-on page)
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
