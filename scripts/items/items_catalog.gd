extends Resource

class_name ItemsCatalog

signal initialized

var currencies: Array[CatalogItem] = []

func init():
	_get_catalog()

func _get_catalog():
	var dict = {
	}
	PlayFabManager.client.post_dict_auth(dict, "/Catalog/SearchItems", PlayFab.AUTH_TYPE.ENTITY_TOKEN, _on_get_catalog)

func _on_get_catalog(response):
	var catalog_items = response.data.Items.map(func (item):
		return CatalogItem.new(item.Id, item.Title.get("NEUTRAL", ""), item.Description.get("NEUTRAL", ""), CatalogItemType.get(item.Type)))
	currencies.append_array(catalog_items.filter(func (catalog_item): return catalog_item.type == CatalogItemType.currency))
	print("Items catalog successfuly initialized")
	initialized.emit()

class CatalogItem:
	var playfab_id: String
	var name: String
	var description: String
	var type: CatalogItemType
	
	func _init(playfab_id: String, name: String, description: String, type: CatalogItemType):
		self.playfab_id = playfab_id
		self.name = name
		self.description = description
		self.type = type

enum CatalogItemType {
	currency
}
