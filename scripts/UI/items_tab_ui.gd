extends Control

@onready var _owned_items_grid: GridContainer = $MarginContainer/HFlowContainer/OwnedItemsGridContainer

@export var _item_view_prefab: PackedScene

func _ready():
	for item in Player.owned_items:
		var item_view = _item_view_prefab.instantiate() as ShopItemView
		item_view.set_item(item)
		_owned_items_grid.add_child(item_view)
