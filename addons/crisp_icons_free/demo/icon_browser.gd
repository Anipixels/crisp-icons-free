extends Control
## Crisp Icons Free demo: every icon in a grid. Type to filter (names and keywords), pick a category
## and a colour variant, click an icon to copy its name.

const Icons := preload("res://addons/crisp_icons_free/crisp_icons.gd")

var variant := "white"
var query := ""
var category := ""
var _cells: Array[Button] = []
var _status: Label
var _bg: ColorRect


func _ready() -> void:
	_bg = ColorRect.new()
	_bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_bg)
	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	for side in ["left", "top", "right", "bottom"]:
		margin.add_theme_constant_override("margin_" + side, 20)
	add_child(margin)
	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 12)
	margin.add_child(column)

	var title := Label.new()
	title.text = "Crisp Icons Free  -  %d icons, white and dark, PNG + SVG" % Icons.names().size()
	title.add_theme_font_size_override("font_size", 24)
	column.add_child(title)

	var bar := HBoxContainer.new()
	bar.add_theme_constant_override("separation", 10)
	column.add_child(bar)
	var search := LineEdit.new()
	search.placeholder_text = "Type to filter: coin, arrow, sound..."
	search.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	search.text_changed.connect(set_query)
	bar.add_child(search)
	var cat_pick := OptionButton.new()
	cat_pick.add_item("all categories")
	for c in Icons.categories():
		cat_pick.add_item(c)
	cat_pick.item_selected.connect(func(i: int) -> void: set_category("" if i == 0 else cat_pick.get_item_text(i)))
	bar.add_child(cat_pick)
	var var_pick := OptionButton.new()
	for v in Icons.VARIANTS:
		var_pick.add_item(v)
	var_pick.item_selected.connect(func(i: int) -> void: set_variant(Icons.VARIANTS[i]))
	bar.add_child(var_pick)

	_status = Label.new()
	column.add_child(_status)
	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	column.add_child(scroll)
	var grid := HFlowContainer.new()
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.add_theme_constant_override("h_separation", 6)
	grid.add_theme_constant_override("v_separation", 6)
	scroll.add_child(grid)
	for icon in Icons.names():
		var cell := Button.new()
		cell.flat = true
		cell.custom_minimum_size = Vector2(88, 88)
		cell.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		cell.tooltip_text = "%s  (%s)" % [icon, Icons.ICONS[icon]]
		cell.set_meta("icon", icon)
		cell.pressed.connect(_copy.bind(icon))
		grid.add_child(cell)
		_cells.append(cell)
	set_variant(variant)


func set_variant(value: String) -> void:
	variant = value
	_bg.color = Color("e6eaf2") if variant == "dark" else Color("1a2030")
	var text_colour := Color("3a4460") if variant == "dark" else Color("a0a6ba")
	_status.add_theme_color_override("font_color", text_colour)
	for cell in _cells:
		cell.icon = Icons.tex(cell.get_meta("icon"), variant)
	_refresh()


func set_query(value: String) -> void:
	query = value.strip_edges().to_lower()
	_refresh()


func set_category(value: String) -> void:
	category = value
	_refresh()


func visible_count() -> int:
	var n := 0
	for cell in _cells:
		if cell.visible:
			n += 1
	return n


func _matches(icon: String) -> bool:
	if query == "" or icon.contains(query):
		return true
	for word: String in Icons.KEYWORDS.get(icon, []):
		if word.begins_with(query):
			return true
	return false


func _refresh() -> void:
	for cell in _cells:
		var icon: String = cell.get_meta("icon")
		cell.visible = (category == "" or Icons.ICONS[icon] == category) and _matches(icon)
	_status.text = "%d of %d icons  -  click one to copy its name  -  CrispIcons.tex(\"coin\")" % [visible_count(), _cells.size()]


func _copy(icon: String) -> void:
	DisplayServer.clipboard_set(icon)
	_status.text = "Copied: " + icon
