extends SceneTree
# Headless check for Crisp Icons Free. Run from the project folder:
#   godot --headless --path . --script res://tests/test_addon.gd
# Loads every PNG and SVG in both variants, checks sizes and the index, exercises the CrispIcons helper and the demo.

const ADDON := "res://addons/crisp_icons_free/"
const EXPECTED := 42
const SIZE := 64

var _bad: Array[String] = []


func _check(ok: bool, what: String) -> void:
	if not ok:
		_bad.append(what)


func _files(base: String, ext: String) -> PackedStringArray:
	var out := PackedStringArray()
	for dir_name in DirAccess.get_directories_at(base):
		out.append_array(_files(base.path_join(dir_name), ext))
	for file_name in DirAccess.get_files_at(base):
		if file_name.ends_with(ext):
			out.append(base.path_join(file_name))
	return out


func _initialize() -> void:
	var Icons = load(ADDON + "crisp_icons.gd")
	_check(Icons != null, "crisp_icons.gd did not load")
	var names: PackedStringArray = Icons.names()
	_check(names.size() == EXPECTED, "expected %d icons, got %d" % [EXPECTED, names.size()])

	# Every icon in every variant, as PNG (through the helper) and as SVG (imported by Godot as a texture).
	var pngs := 0
	var svgs := 0
	for variant: String in Icons.VARIANTS:
		for icon in names:
			var texture: Texture2D = Icons.tex(icon, variant)
			_check(texture != null and texture.get_width() == SIZE and texture.get_height() == SIZE, "%s/%s: PNG missing or not %d px" % [variant, icon, SIZE])
			if texture != null:
				pngs += 1
			var vector := load(Icons.svg_path(icon, variant)) as Texture2D
			_check(vector != null and vector.get_width() == SIZE, "%s/%s: SVG missing or not %d px" % [variant, icon, SIZE])
			if vector != null:
				svgs += 1
	# Nothing on disk that the index does not know about.
	var on_disk := _files(ADDON + "icons", ".png")
	var svg_on_disk := _files(ADDON + "svg", ".svg")
	for path in on_disk + svg_on_disk:
		_check(Icons.has(path.get_file().get_basename()), "not in the index: " + path)
	_check(on_disk.size() == pngs and svg_on_disk.size() == svgs, "files on disk: %d PNG, %d SVG" % [on_disk.size(), svg_on_disk.size()])

	# White icons are plain white (so modulate recolours them); dark icons are dark.
	var white: Image = Icons.tex("star", "white").get_image()
	var dark: Image = Icons.tex("star", "dark").get_image()
	var centre := Vector2i(SIZE / 2, SIZE / 2)
	_check(white.get_pixelv(centre).r > 0.95 and white.get_pixelv(centre).a > 0.9, "white star is not white in the middle")
	_check(dark.get_pixelv(centre).r < 0.5 and dark.get_pixelv(centre).a > 0.9, "dark star is not dark in the middle")

	# Helper: categories cover every icon once; lookups.
	var in_categories := 0
	for category in Icons.categories():
		in_categories += Icons.names(category).size()
	_check(in_categories == names.size(), "categories list %d icons" % in_categories)
	_check(Icons.has("coin") and not Icons.has("no_such_icon"), "has()")
	_check(Icons.path("coin", "dark") == ADDON + "icons/dark/economy/coin.png", "path(): " + Icons.path("coin", "dark"))
	_check(Icons.KEYWORDS.size() == names.size(), "keywords for %d icons" % Icons.KEYWORDS.size())

	# The demo: one cell per icon, filters by name, keyword and category, switches variant.
	var demo: Control = (load(ADDON + "demo/icon_browser.tscn") as PackedScene).instantiate()
	root.add_child(demo)
	await process_frame
	var all_cells: int = demo.visible_count()
	demo.set_query("coin")
	var coin: int = demo.visible_count()
	demo.set_query("money")
	var money: int = demo.visible_count()
	demo.set_query("")
	demo.set_category("arrows")
	var arrows: int = demo.visible_count()
	demo.set_category("")
	for variant: String in Icons.VARIANTS:
		demo.set_variant(variant)
		await process_frame
	_check(all_cells == names.size(), "demo shows %d cells" % all_cells)
	_check(coin >= 1 and coin < all_cells, "search 'coin' found %d" % coin)
	_check(money >= 1 and money < all_cells, "keyword search 'money' found %d" % money)
	_check(arrows == Icons.names("arrows").size(), "category filter 'arrows' found %d" % arrows)

	print("RESULT icons=%d categories=%d png_loaded=%d svg_loaded=%d demo_cells=%d search_coin=%d keyword_money=%d category_arrows=%d bad=%s" % [
		names.size(), Icons.categories().size(), pngs, svgs, all_cells, coin, money, arrows, str(_bad)])
	quit(0 if _bad.is_empty() and pngs == EXPECTED * 2 and svgs == EXPECTED * 2 else 1)
