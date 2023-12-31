extends Control

@onready var _my_items_container: HBoxContainer = $ScrollContainer/MarginContainer/ItemsContainer/MyItemsContainer
@onready var _owned_items_grid: GridContainer = $ScrollContainer/MarginContainer/ItemsContainer/OwnedItemsGridContainer
@onready var _item_details_popup: ItemDetailsPopup = $ItemDetailsPopup

@export var _item_view_prefab: PackedScene
@export var _items_catalog: ItemsCatalog

func _ready() -> void:
	Player.selected_items_changed.connect(_prepare_player_items_view)
	Player.selected_items_changed.connect(_prepare_player_not_used_items_view)
	_item_details_popup.use_item.connect(_on_use_item)
	_prepare_player_items_view()
	_prepare_player_not_used_items_view()

func _create_item_view() -> ItemSlotView:
	var item_view = _item_view_prefab.instantiate() as ItemSlotView
	item_view.selected.connect(_on_item_selected.bind(item_view))
	return item_view

func _prepare_player_items_view() -> void:
	for slot_index in Equipment.Slot.values():
		var item = Player.selected_items.get(slot_index, null)
		if item:
			var item_container = _my_items_container.get_child(slot_index)
			if item_container.get_child_count() > 1:
				item_container.get_child(1).queue_free()
			var item_view = _create_item_view()
			item_view.ready.connect(item_view.set_item.bind(item))
			item_container.add_child(item_view)

func _prepare_player_not_used_items_view() -> void:
	for child: Node in _owned_items_grid.get_children():
		_owned_items_grid.remove_child(child)
		child.queue_free()
	var owned_unused_items = Player.owned_items \
		.filter(func (player_equipment: PlayerEquipment): return not Player.selected_items.values().has(player_equipment))
	owned_unused_items.sort_custom(func (a: PlayerEquipment, b: PlayerEquipment): return a.equipment.slot < b.equipment.slot)
	for player_equipment: PlayerEquipment in owned_unused_items:
		var item_view = _create_item_view()
		item_view.ready.connect(item_view.set_item.bind(player_equipment))
		_owned_items_grid.add_child(item_view)

func _on_item_selected(item_view: ItemSlotView) -> void:
	if item_view.item:
		_item_details_popup.set_item(item_view.item)

func _on_use_item(player_item: PlayerEquipment) -> void:
	Player.change_selected_item(player_item)
