extends Control

@onready var _head_item_view: ItemSlotView = $MarginContainer/HFlowContainer/MyItemsContainer/HeadSlot
@onready var _right_hand_item_view: ItemSlotView = $MarginContainer/HFlowContainer/MyItemsContainer/RightHandSlot
@onready var _left_hand_item_view: ItemSlotView = $MarginContainer/HFlowContainer/MyItemsContainer/LeftHandSlot
@onready var _boots_item_view: ItemSlotView = $MarginContainer/HFlowContainer/MyItemsContainer/BootsSlot
@onready var _owned_items_grid: GridContainer = $MarginContainer/HFlowContainer/OwnedItemsGridContainer

@export var _item_view_prefab: PackedScene

func _ready():
	_prepare_player_items_view()
	for item in Player.owned_items:
		var item_view = _item_view_prefab.instantiate() as ItemSlotView
		item_view.set_item(item)
		_owned_items_grid.add_child(item_view)

func _prepare_player_items_view():
	var head_item: Equipment = Player.selected_items.get(Equipment.Slot.Head, null)
	_head_item_view.set_item(head_item)
	var right_hand_item: Equipment = Player.selected_items.get(Equipment.Slot.RightHand, null)
	_right_hand_item_view.set_item(right_hand_item)
	var left_hand_item: Equipment = Player.selected_items.get(Equipment.Slot.LeftHand, null)
	_left_hand_item_view.set_item(left_hand_item)
	var boots_item: Equipment = Player.selected_items.get(Equipment.Slot.Boots, null)
	_boots_item_view.set_item(boots_item)
