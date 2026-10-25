# Matter Window Covering Tilt

This SmartThings Edge driver is based on the stock Matter Window Covering driver. It adds relative tilt stepping using the standard `statelessWindowShadeLevelStep` capability on a dedicated `tilt` component. The absolute tilt level remains on `main`, matching the stock driver and SmartThings device UI. A positive `stepSize` moves the tilt percentage up, a negative value moves it down, and the target is clamped to 0–100 before sending Matter `GoToTiltPercentage`.

## Tilt step control

No custom capability or presentation registration is required. The absolute tilt slider is on `main`; the `tilt` component exposes the relative step command only.

## Package and install

Install and authenticate the [SmartThings CLI](https://developer.smartthings.com/docs/smartthings-cli/getting-started), create a driver channel, and enroll the target hub in it:

```sh
smartthings edge:channels:enroll <hub-id> --channel <channel-id>
```

The driver project is the `matter-window-covering` directory (it contains `config.yml`). Packaging from the repository root without that path fails with `missing main config.yaml (or config.yml) file`.

From the repository root, package and upload the driver (optionally assign it to a channel and install it on a hub in one step):

```sh
smartthings edge:drivers:package matter-window-covering
smartthings edge:drivers:package matter-window-covering --channel <channel-id> --hub <hub-id>
```

Or `cd matter-window-covering` first, then run `smartthings edge:drivers:package` with no project argument.

Assign the resulting driver version to your channel, then install it on the hub (if you did not pass `--channel` / `--hub` to `package`):

```sh
smartthings edge:channels:assign <driver-id> <version> --channel <channel-id>
smartthings edge:drivers:install --hub <hub-id> --channel <channel-id>
```

In the SmartThings app, open the Matter window-covering device and change its driver to **Matter Window Covering Tilt**. The tilt profiles use distinct names ending in `-rel`, so the driver re-applies a profile with the updated capability layout during initialization; if needed, select the matching `window-covering-tilt-rel*` profile manually. Force-close and reopen the app if the device page still shows cached controls. The generic Matter `windowcovering` fingerprint remains enabled for unmatched Matter Window Covering devices.

When switching back to the stock driver, its profile selection is controlled by that driver. If the absolute tilt control is missing, select the stock driver's tilt-capable window-covering profile (not a lift-only profile), then refresh/reopen the device page.

Set **Tilt step size** in the device preferences; the value is restricted to 1–100 and defaults to 25 percent. The preference is used when a tilt step command has no `stepSize`; otherwise the command's signed value is applied directly. Tilt values are clamped to 0–100, matching the absolute tilt-level scale. As in the upstream driver, the `reverse` preference does not invert absolute tilt-level commands.

## Tests

Run the platform-independent tilt math checks with Lua:

```sh
lua tests/test_relative_tilt.lua
```

The stock Matter integration test remains under `src/test` and requires the SmartThings Edge test harness.