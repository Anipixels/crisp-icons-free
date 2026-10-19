class_name CrispIcons
extends RefCounted
## Crisp Icons Free lookup:
## [codeblock]
## $Button.icon = CrispIcons.tex("coin")            # white: tint it with modulate or the theme's icon colours
## $Sprite.texture = CrispIcons.tex("coin", "dark")
## [/codeblock]
## The PNGs are 64 px. The SVGs (svg_path()) are imported by Godot as textures too; raise their import scale for bigger sizes.

const BASE := "res://addons/crisp_icons_free/icons/"
const SVG_BASE := "res://addons/crisp_icons_free/svg/"
const VARIANTS: PackedStringArray = ["white", "dark"]
## icon name -> category folder
const ICONS := {
	"close": "interface",
	"check": "interface",
	"plus": "interface",
	"menu": "interface",
	"home": "interface",
	"settings": "interface",
	"search": "interface",
	"info": "interface",
	"lock": "interface",
	"arrow_left": "arrows",
	"arrow_right": "arrows",
	"refresh": "arrows",
	"play": "media",
	"pause": "media",
	"sound_on": "media",
	"sound_off": "media",
	"music": "media",
	"restart": "game",
	"star": "game",
	"heart": "game",
	"trophy": "game",
	"shield": "game",
	"gamepad": "game",
	"coin": "economy",
	"gem": "economy",
	"cart": "economy",
	"gift": "economy",
	"user": "social",
	"chat": "social",
	"mail": "social",
	"hammer": "items",
	"bomb": "items",
	"potion": "items",
	"apple": "food",
	"run": "actions",
	"jump": "actions",
	"phone": "devices",
	"tap": "devices",
	"sun": "nature",
	"fire": "nature",
	"face_smile": "faces",
	"sparkle": "shapes",
}
## icon name -> search keywords (from manifest.json)
const KEYWORDS := {
	"close": ["close", "x", "cancel", "exit", "dismiss", "interface"],
	"check": ["check", "tick", "ok", "confirm", "done", "yes", "interface"],
	"plus": ["plus", "add", "new", "more", "interface"],
	"menu": ["menu", "hamburger", "navigation", "interface"],
	"home": ["home", "house", "main", "menu", "lobby", "interface"],
	"settings": ["settings", "gear", "cog", "options", "preferences", "interface"],
	"search": ["search", "find", "magnifier", "lens", "interface"],
	"info": ["info", "about", "details", "help", "interface"],
	"lock": ["lock", "locked", "secure", "padlock", "interface"],
	"arrow_left": ["arrow", "left", "direction", "next", "back", "arrows"],
	"arrow_right": ["arrow", "right", "direction", "next", "back", "arrows"],
	"refresh": ["refresh", "sync", "reload", "update", "arrows"],
	"play": ["play", "start", "resume", "go", "media"],
	"pause": ["pause", "hold", "break", "media"],
	"sound_on": ["sound", "on", "volume", "audio", "speaker", "loud", "media"],
	"sound_off": ["sound", "off", "mute", "volume", "audio", "silent", "media"],
	"music": ["music", "notes", "song", "audio", "bgm", "media"],
	"restart": ["restart", "replay", "retry", "again", "reset", "game"],
	"star": ["star", "favourite", "rate", "rating", "reward", "game"],
	"heart": ["heart", "life", "love", "like", "health", "favourite", "game"],
	"trophy": ["trophy", "cup", "win", "prize", "champion", "achievement", "game"],
	"shield": ["shield", "defense", "defence", "protect", "armor", "guard", "game"],
	"gamepad": ["gamepad", "controller", "play", "games", "pad", "game"],
	"coin": ["coin", "money", "gold", "currency", "token", "economy"],
	"gem": ["gem", "diamond", "jewel", "premium", "currency", "crystal", "economy"],
	"cart": ["cart", "shop", "buy", "store", "basket", "trolley", "economy"],
	"gift": ["gift", "present", "reward", "bonus", "box", "free", "economy"],
	"user": ["user", "profile", "account", "player", "person", "avatar", "social"],
	"chat": ["chat", "message", "typing", "talk", "speech", "social"],
	"mail": ["mail", "email", "message", "envelope", "inbox", "letter", "social"],
	"hammer": ["hammer", "build", "craft", "tool", "repair", "forge", "items"],
	"bomb": ["bomb", "explode", "explosive", "blast", "booster", "items"],
	"potion": ["potion", "bottle", "booster", "elixir", "health", "mana", "items"],
	"apple": ["apple", "fruit", "food", "health", "eat"],
	"run": ["run", "sprint", "move", "player", "character", "fast", "actions"],
	"jump": ["jump", "leap", "hop", "player", "move", "up", "actions"],
	"phone": ["phone", "mobile", "smartphone", "device", "portrait", "devices"],
	"tap": ["tap", "touch", "press", "finger", "click", "gesture", "devices"],
	"sun": ["sun", "day", "light", "weather", "bright", "summer", "nature"],
	"fire": ["fire", "flame", "hot", "burn", "element", "streak", "combo", "nature"],
	"face_smile": ["face", "smile", "happy", "emoji", "smiley", "good", "mood", "faces"],
	"sparkle": ["sparkle", "shine", "star", "magic", "new", "glint", "shapes"],
}


static func has(icon: String) -> bool:
	return ICONS.has(icon)


static func path(icon: String, variant: String = "white") -> String:
	return BASE + variant + "/" + String(ICONS[icon]) + "/" + icon + ".png"


static func svg_path(icon: String, variant: String = "white") -> String:
	return SVG_BASE + variant + "/" + String(ICONS[icon]) + "/" + icon + ".svg"


static func tex(icon: String, variant: String = "white") -> Texture2D:
	if not ICONS.has(icon):
		push_warning("CrispIcons: no icon named '%s'" % icon)
		return null
	return load(path(icon, variant)) as Texture2D


static func names(category: String = "") -> PackedStringArray:
	var out: PackedStringArray = []
	for icon: String in ICONS:
		if category == "" or ICONS[icon] == category:
			out.append(icon)
	return out


static func categories() -> PackedStringArray:
	var out: PackedStringArray = []
	for icon: String in ICONS:
		if not out.has(ICONS[icon]):
			out.append(ICONS[icon])
	return out
