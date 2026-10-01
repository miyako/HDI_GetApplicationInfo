# HDI_GetApplicationInfo

![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue&logo=4d)
![4D](https://img.shields.io/static/v1?label=4D&message=21%2B&color=blue)
![license](https://img.shields.io/github/license/miyako/HDI_GetApplicationInfo)

**How Do I** (HDI) example: read live runtime information about the running 4D application with the [`Application info`](https://developer.4d.com/docs/commands/application-info) command.

The example opens a splash window and a tabbed dashboard that refreshes every second. It shows whether 4D runs as local, remote, or server, plus uptime, CPU use, network throughput, TLS, listening ports, and IP allow/deny rules.

## Requirements

| | |
|---|---|
| 4D | 21 or later to open the project (the demo itself needs 4D v17 R3+) |
| Mode | Interpreted project; no license needed |
| Platforms | macOS and Windows |

## Getting started

1. Open `Project/HDI_GetApplicationInfo.4DProject` in 4D.
2. The splash form appears on startup (`On Startup` calls `00_Start`). Click **Demo**.
3. To reopen it later, use **File > Demo** (Cmd/Ctrl+K).
4. Run it in 4D Remote or 4D Server as well. Some properties (`portID`, `TLSEnabled`, IP lists) are only returned in client/server mode.

## What it demonstrates

- Reading the whole `Application info` object once per refresh and binding its properties straight to form inputs through `Form`.
- Detecting the execution mode with `Application type` (`4D Local mode`, `4D Remote mode`, `4D Server`).
- Handling properties that are absent depending on the mode (`null` checks, with a localised "not returned" message).
- Mapping the volume shadow copy (VSS) constants to readable text.
- Showing `IPAddressesAllowDeny` in a collection list box.
- Generating CPU load with workers (`CALL WORKER` ×8) so the `cpuUsage` figure visibly moves.
- Refreshing with `SET TIMER` and `On Timer`.

## Points of interest

| Topic | Where to look |
|---|---|
| Startup and window reuse | `Methods/00_Start.4dm`: `#DECLARE`, `CALL WORKER(1; ...)`, `DIALOG(...; *)`, and reuse of an already open window |
| Passing state between dialogs | `Forms/HDI/ObjectMethods/BtnDemo.4dm` passes `Form` to the next `DIALOG` |
| Data refresh | `Methods/refreshData.4dm` (`Application info`, null handling, localised labels) |
| Version gate | `Forms/HDI/method.4dm` compares `Application version` with the minimum required version and offers *Close* instead of *Demo* |
| Menu standard actions | `menus.json` uses `"action": "quit"` etc. instead of wrapper methods |
| Content stored in data | The tab titles and descriptions live in the `INFO` table and are imported from `Resources/INFO.4ie` on first launch |

## Project layout

```
Project/
  Sources/
    DatabaseMethods/    onStartup, onServerStartup -> 00_Start
    Forms/HDI/          splash dialog
    Forms/HDI2/         tabbed dashboard (list box, live values)
    TableForms/1/       INFO table input/output forms
    Methods/            00_Start, refreshData, initTexts, cpuConsume, RW
    styleSheets*.css    dark mode and platform themes
    menus.json
Resources/
  en.lproj/ ja.lproj/   XLIFF localisation (menu, forms, messages)
  INFO.4ie / INFO.4si   seed data for the INFO table
  Images/               background and record-navigation icons
```

## Appearance and localisation

- **Dark mode:** colours use `automatic` / `automaticAlternate` or CSS classes with `prefers-color-scheme` media queries in `styleSheets.css`.
- **macOS Tahoe (Liquid Glass):** `styleSheets_mac.css` sets push button height per `form-theme` (27 px for `liquid-glass`, 23 px for `mac-classic`). Windows has equivalent rules in `styleSheets_windows.css`.
- **Languages:** English and Japanese. Forms and menus use `:xliff:` references and code uses `Localized string`. 4D's built-in `Common*` strings are reused for standard menu items.

## References

- Blog: [Get info about the running application](https://blog.4d.com/get-info-about-the-running-application/)
- Docs: [`Application info`](https://developer.4d.com/docs/commands/application-info), [`Application type`](https://developer.4d.com/docs/commands/application-type), [`CALL WORKER`](https://developer.4d.com/docs/commands/call-worker), [`DIALOG`](https://developer.4d.com/docs/commands/dialog), [CSS in forms](https://developer.4d.com/docs/FormEditor/stylesheets), [Menu standard actions](https://developer.4d.com/docs/Menus/properties)

## Origin

Originally a binary `.4DB` database published by 4D ([download](https://download.4d.com/Demos/4D_v17_R3/HDI_GetApplicationInfo.zip)), converted to a 4D project with 4D 21 and then modernised. The modernisation rules are in [`.github/instructions`](.github/instructions).

## License

[MIT](LICENSE)
