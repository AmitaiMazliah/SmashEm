extends Control

@onready var _items_grid: GridContainer = $ScrollContainer/MarginContainer/GridContainer

@export var _item_view_prefab: PackedScene
@export var _items_catalog: ItemsCatalog

func _ready():
	var player_items = Player.owned_items.map(func (player_equip: PlayerEquipment): return player_equip.equipment)
	var shop_items = _items_catalog.equipment.filter(func (i: Equipment): return not player_items.has(i))
	for item in shop_items:
		var item_view = _item_view_prefab.instantiate() as ShopItemView
		item_view.ready.connect(item_view.set_item.bind(item))
		item_view.pressed.connect(_select_item.bind(item))
		_items_grid.add_child(item_view)

func _select_item(item: Equipment):
	print("You have selected ", item.name)
