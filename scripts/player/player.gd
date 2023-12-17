extends Node

signal selected_items_changed

var nickname: String

@export var gold: IntVariable
@export var crystals: IntVariable
@export var trophy_count: IntVariable

var selected_items: Dictionary
var owned_items: Array[PlayerEquipment]
@export var chests: Array[PlayerChest]

func init(items_catalog: ItemsCatalog):
	Player.owned_items.append_array(items_catalog.equipment.map(func (e): return PlayerEquipment.new(e, 1, 1)))
	await _get_player_profile()
	await _get_player_currencies(items_catalog)
	await _get_player_data()
	print("Player initialized successfully")

func change_selected_item(selected_item: PlayerEquipment):
	_update_player_data({
		"SelectedItem-" + str(selected_item.equipment.slot): selected_item.equipment.name
	})
	selected_items[selected_item.equipment.slot] = selected_item
	selected_items_changed.emit()

func _get_player_currencies(items_catalog: ItemsCatalog):
	var dict = {
		"Filter": "type eq 'currency'"
	}
	var result = await MyPlayFab.send_request(dict, "/Inventory/GetInventoryItems", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled
	if result.status == Promise.Status.RESOLVED:
		var gold_playfab_id = items_catalog.currencies.filter(func (c): return c.name == "Gold")[0].playfab_id
		var crystal_playfab_id = items_catalog.currencies.filter(func (c): return c.name == "Crystal")[0].playfab_id
		
		for currency in result.payload.data.Items:
			if currency.Id == gold_playfab_id:
				gold.value = currency.Amount
			elif currency.Id == crystal_playfab_id:
				crystals.value = currency.Amount

func _get_player_profile():
	var result = await MyPlayFab.send_request({}, "/Client/GetPlayerProfile", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled
	if result.status == Promise.Status.RESOLVED:
		nickname = result.payload.data.PlayerProfile.DisplayName

func _get_player_data():
	var result = await MyPlayFab.send_request({}, "/Client/GetUserData", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled
	if result.status == Promise.Status.RESOLVED:
		trophy_count.value = result.payload.data.Data.get("trophy_count", 0)
		owned_items
		selected_items[Equipment.Slot.Head] = _get_player_equipment_from_playfab_response(result.payload.data.Data, Equipment.Slot.Head)
		selected_items[Equipment.Slot.RightHand] = _get_player_equipment_from_playfab_response(result.payload.data.Data, Equipment.Slot.RightHand)
		selected_items[Equipment.Slot.LeftHand] = _get_player_equipment_from_playfab_response(result.payload.data.Data, Equipment.Slot.LeftHand)
		selected_items[Equipment.Slot.Boots] = _get_player_equipment_from_playfab_response(result.payload.data.Data, Equipment.Slot.Boots)

func _update_player_data(data: Dictionary):
	var payload = {
		"Data": data
	}
	await MyPlayFab.send_request(payload, "/Client/UpdateUserData", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled

func _get_player_equipment_from_playfab_response(data: Dictionary, slot: Equipment.Slot) -> PlayerEquipment:
	var saved_equipment = data.get("SelectedItem-" + str(slot), null)
	if not saved_equipment:
		return null
	var equipment_name = saved_equipment.Value
	var filtered_equipment = owned_items.filter(func (player_equipment: PlayerEquipment): return player_equipment.equipment.name == equipment_name)
	if len(filtered_equipment) == 0:
		return null
	else:
		return filtered_equipment[0]
