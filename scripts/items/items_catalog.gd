extends Resource

class_name ItemsCatalog

var currencies: Array[CatalogItem] = []
var equipment: Array[Equipment]

func init():
	await _get_catalog()
	equipment = _get_items_catalog()
	print("Items catalog successfuly initialized")

func _get_catalog():
	var result: Promise.PromiseResult = await MyPlayFab.send_request({}, "/Catalog/SearchItems", PlayFab.AUTH_TYPE.ENTITY_TOKEN).settled
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
			var item = load("res://resources/items/" + file_name.trim_suffix('.remap'))
			if item:
				items.append(item)
			file_name = dir.get_next()
	return items

class CatalogItem:
	var playfab_id: String
	var name: String
	var description: String
	var type: CatalogItemType
	
	func _init(_playfab_id: String, _name: String, _description: String, _type: CatalogItemType):
		playfab_id = _playfab_id
		name = _name
		description = _description
		type = _type

enum CatalogItemType {
	currency
}
