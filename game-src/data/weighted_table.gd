class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum: int = 0


func add_item(item, weight: int) -> void:
	items.append({ 
		"item": item, 
		"weight": weight
	})
	weight_sum += weight


func pick_item(execlude_items: Array = []):
	
	var adjusted_items: Array[Dictionary] = items
	var adjusted_weight_sum: int = weight_sum
	
	if execlude_items.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		
		for item in items:
			if item["item"] in execlude_items:
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item["weight"]
	
	var chosen_weight: int = randi_range(0, adjusted_weight_sum)
	var iteration_sum: int = 0
	
	for item in adjusted_items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
	
	return null


func remove_item(item_to_remove) -> Array[Dictionary]:
	items = items.filter(func(item): 
		return item["item"]["id"] !=  item_to_remove.id
	)

	# Update weight
	weight_sum = 0
	for item in items:
		weight_sum += item["weight"]
		
	return items
