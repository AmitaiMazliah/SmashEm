extends Control

#@onready var _head_item_view: ItemSlotView = $MarginContainer/HFlowContainer/MyItemsContainer/HeadSlot
#@onready var _right_hand_item_view: ItemSlotView = $MarginContainer/HFlowContainer/MyItemsContainer/RightHandSlot
#@onready var _left_hand_item_view: ItemSlotView = $MarginContainer/HFlowContainer/MyItemsContainer/LeftHandSlot
#@onready var _boots_item_view: ItemSlotView = $MarginContainer/HFlowContainer/MyItemsContainer/BootsSlot
@onready var _my_items_container: HBoxContainer = $ScrollContainer/MarginContainer/HFlowContainer/MyItemsContainer
@onready var _owned_items_grid: GridContainer = $ScrollContainer/MarginContainer/HFlowContainer/OwnedItemsGridContainer

@export var _item_view_prefab: PackedScene

var _selected_item: ItemSlotView

func _ready():
	_prepare_player_items_view()
	
	var items = _get_items_catalog()
	Player.owned_items.append_array(items.map(func (e): return PlayerEquipment.new(e, 1, 1)))
	
	for item in Player.owned_items:
		var item_view = _create_item_view()
		item_view.ready.connect(item_view.set_item.bind(item))
		_owned_items_grid.add_child(item_view)

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

func _create_item_view() -> ItemSlotView:
	var item_view = _item_view_prefab.instantiate() as ItemSlotView
	item_view.selected.connect(_on_item_selected.bind(item_view))
	return item_view

func _prepare_player_items_view():
	for slot in Equipment.Slot:
		var item = Player.selected_items.get(slot, null)
		var item_view = _create_item_view()
		item_view.ready.connect(item_view.set_item.bind(item))
		_my_items_container.add_child(item_view)
#	var head_item: Equipment = Player.selected_items.get(Equipment.Slot.Head, null)
#	_head_item_view.set_item(head_item)
#	var right_hand_item: Equipment = Player.selected_items.get(Equipment.Slot.RightHand, null)
#	_right_hand_item_view.set_item(right_hand_item)
#	var left_hand_item: Equipment = Player.selected_items.get(Equipment.Slot.LeftHand, null)
#	_left_hand_item_view.set_item(left_hand_item)
#	var boots_item: Equipment = Player.selected_items.get(Equipment.Slot.Boots, null)
#	_boots_item_view.set_item(boots_item)

func _on_item_selected(item_view: ItemSlotView):
	if _selected_item and _selected_item != item_view:
		_selected_item.is_selected = false
		
	item_view.is_selected = not item_view.is_selected
	_selected_item = item_view

func on_close():
	if _selected_item:
		_selected_item.is_selected = false
