extends Node

var nickname: String

@export var gold: IntVariable
@export var trophy_count: IntVariable

var selected_items: Dictionary
var owned_items: Array[PlayerEquipment]

func init(items_catalog: ItemsCatalog):
	await _get_player_currencies(items_catalog)
	await _get_player_data()
	print("Player initialized successfully")

func _get_player_currencies(items_catalog: ItemsCatalog):
	var dict = {
		"Filter": "type eq 'currency'"
	}
	var result = await MyPlayFab.send_request(dict, "/Inventory/GetInventoryItems", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled
	if result.status == Promise.Status.RESOLVED:
		var gold_playfab_id = items_catalog.currencies.filter(func (c): return c.name == "Gold")[0].playfab_id
		
		for currency in result.payload.data.Items:
			if currency.Id == gold_playfab_id:
				gold.value = currency.Amount

func _get_player_data():
	var result = await MyPlayFab.send_request({}, "/Client/GetUserData", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled
	if result.status == Promise.Status.RESOLVED:
		trophy_count.value = result.payload.data.Data.get("trophy_count", 0)
