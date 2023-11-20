extends Control

@onready var _items_grid: GridContainer = $ScrollContainer/MarginContainer/GridContainer

@export var _item_view_prefab: PackedScene

func _ready():
	var items = _get_items_catalog()
	var shop_items = items.filter(func (i): return not Player.owned_items.has(i))
	for item in shop_items:
		var item_view = _item_view_prefab.instantiate() as ShopItemView
		item_view.ready.connect(item_view.set_item.bind(item))
		item_view.pressed.connect(_select_item.bind(item))
		_items_grid.add_child(item_view)

func _get_items_catalog() -> Array[Equipment]:
	var items: Array[Equipment] = []
	var dir = DirAccess.open("res://resources/items/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print("File name: ", file_name)
			var item = load("res://resources/items/" + file_name)
			if item:
				items.append(item)
			file_name = dir.get_next()
	return items

func _select_item(item: Equipment):
	print("You have selected ", item.name)
