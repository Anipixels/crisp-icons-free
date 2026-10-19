# Asset Library submission - Crisp Icons Free

Paste these into https://godotengine.org/asset-library/asset/submit (log in first). Nothing has been submitted or pushed yet.
The repository URL assumes the GitHub account is `Anipixels` and the repository is named as suggested; adjust if not.

| Field | Value |
|---|---|
| Asset Name (title) | Crisp Icons Free - 42 Game UI Icons (PNG + SVG) |
| Category | 2D Tools |
| Godot version | 4.3 (tested only on 4.7.2 stable (the .NET editor build, run headless on Windows 11); see the note below) |
| Version | 1.0.0 |
| Repository host | GitHub |
| Repository URL | https://github.com/Anipixels/crisp-icons-free |
| Issues URL | https://github.com/Anipixels/crisp-icons-free/issues |
| Download Commit | the full 40-character hash of the commit you pushed (`git rev-parse HEAD`) |
| Icon URL | https://raw.githubusercontent.com/Anipixels/crisp-icons-free/main/icon.png |
| License | CC-BY-4.0 (the form takes one licence; the description says the GDScript is MIT) |
| Suggested repo name | crisp-icons-free |

Preview: type **Image**, image URL and thumbnail URL both
`https://raw.githubusercontent.com/Anipixels/crisp-icons-free/main/screenshot.png`

## Short description

(For the GitHub repository "About" line; the Asset Library form has no short-description field.)

42 free rounded, bold game UI icons in white and dark, as 64 px PNG and SVG, with a one-line lookup helper (CrispIcons.tex("coin")) and a searchable icon browser scene.

## Description (long)

```
42 rounded, bold game UI icons in white and dark, as 64 px PNG and SVG, with a lookup helper and an icon browser scene.

Icons: close, check, plus, menu, search, home, settings, info, lock, arrows, refresh, play, pause, sound on / off, music, restart,
trophy, star, heart, shield, gamepad, coin, gem, cart, gift, user, chat, mail, hammer, bomb, potion, apple, run, jump, phone, tap,
sun, fire, smile and sparkle - in 13 category folders.

- One line to use one: $Button.icon = CrispIcons.tex("coin")   (or CrispIcons.tex("coin", "dark"))
- White icons are plain white on transparent: recolour them with modulate or a theme's icon colours.
- SVGs are imported by Godot as textures too; raise their import scale for 128 or 256 px.
- CrispIcons also has names(category), categories(), has(name), path(), svg_path() and search KEYWORDS from manifest.json.
- Demo scene: addons/crisp_icons_free/demo/icon_browser.tscn (search by name or keyword, filter by category, switch white / dark).

Installs into addons/crisp_icons_free. GDScript only. Written for Godot 4.3+, tested on 4.7.2.

This is the free sampler of Crisp Icons, which has 590 icons in white, dark and 8 badge colours, PNG at 32 - 256 px and SVG:
https://anipixels.itch.io/crisp-icons
Or get every Crisp pack in one bundle: https://itch.io/s/203391/crisp-everything-bundle

Licence: icons (PNG, SVG), manifest.json and scene files CC BY 4.0 (credit "Crisp Icons Free by Anipixels" with the link above); GDScript MIT.
How it was made: every shape is drawn procedurally by code written with an AI assistant (Claude). No AI image generators.
```

## Notes before you submit

- Godot version: the addon is written for 4.3+, but it has only been run on 4.7.2. Choosing "4.3" in the form is a claim that
  it works there. If you would rather claim only what was tested, pick the newest 4.x entry the form offers instead.
- The `.gitattributes` file marks everything except `addons/` as `export-ignore`, so the zip the Asset Library downloads
  contains only `addons/crisp_icons_free/` (with its own README and licence copy).
