extends Node

signal gold_changed(gold: int)

signal currencies_initialized

var nickname: String
var gold: int :
	set (value):
		gold = value
		gold_changed.emit(gold)
	get:
		return gold
var selected_items: Dictionary
var owned_items: Array[PlayerEquipment]

func init(items_catalog: ItemsCatalog):
	_get_player_currencies(items_catalog)
	await currencies_initialized
	print("Player initialized successfully")

func _get_player_currencies(items_catalog: ItemsCatalog):
	var dict = {
		"Filter": "type eq 'currency'"
	}
	PlayFabManager.client.post_dict_auth(dict, "/Inventory/GetInventoryItems", PlayFab.AUTH_TYPE.ENTITY_TOKEN, _on_get_player_currencies.bind(items_catalog))

func _on_get_player_currencies(response, items_catalog: ItemsCatalog):
	var gold_playfab_id = items_catalog.currencies.filter(func (c): return c.name == "Gold")[0].playfab_id
	
	for currency in response.data.Items:
		if currency.Id == gold_playfab_id:
			gold = currency.Amount
	
	currencies_initialized.emit()
