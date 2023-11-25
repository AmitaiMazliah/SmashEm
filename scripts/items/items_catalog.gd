extends Resource

class_name ItemsCatalog

var currencies: Array[CatalogItem] = []
var equipment: Array[Equipment]

func init():
	await _get_catalog()
	equipment = _get_items_catalog()
	print("Items catalog successfuly initialized")

func _get_catalog():
	var dict = {
	}
	var result = await MyPlayFab.send_request(dict, "/Catalog/SearchItems", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled
	if result.status == Promise.Status.RESOLVED:
		var catalog_items = result.payload.data.Items.map(func (item):
			return CatalogItem.new(item.Id, item.Title.get("NEUTRAL", ""), item.Description.get("NEUTRAL", ""), CatalogItemType.get(item.Type)))
		currencies.append_array(catalog_items.filter(func (catalog_item): return catalog_item.type == CatalogItemType.currency))

func _get_items_catalog() -> Array[Equipment]:
	var items: Array[Equipment] = []
	var dir = DirAccess.open("res://resources/items/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var item = load("res://resources/items/" + file_name)
			if item:
				items.append(item)
			file_name = dir.get_next()
	return items

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
