extends Resource

class_name ItemsCatalog

var currencies: Array[CatalogItem] = []

func init():
	await _get_catalog()
	print("Items catalog successfuly initialized")

func _get_catalog():
	var dict = {
	}
	var result = await MyPlayFab.send_request(dict, "/Catalog/SearchItems", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled
	if result.status == Promise.Status.RESOLVED:
		var catalog_items = result.payload.data.Items.map(func (item):
			return CatalogItem.new(item.Id, item.Title.get("NEUTRAL", ""), item.Description.get("NEUTRAL", ""), CatalogItemType.get(item.Type)))
		currencies.append_array(catalog_items.filter(func (catalog_item): return catalog_item.type == CatalogItemType.currency))

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
