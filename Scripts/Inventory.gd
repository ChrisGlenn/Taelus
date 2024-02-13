class_name Inventory

#[
	#{"item": 0},
	#{"item": 1,"control": "sel_drink","name": "WATERSKIN","desc": "A waterskin made of leather.","amnt": 5,"max_amnt": 5,"min_amnt": -4,"weight": 0.2,"type": "CONSUME","func_one": [1,50.0],"func_two": [0],"func_three": [0]},
	#{"item": 2,"control": "sel_eat","name": "RATION","desc": "A bowl of food.","amnt": 1,"max_amnt": 99,"min_amnt": 0,"weight": 0.5,"type": "CONSUME","func_one": [1,30.0],"func_two": [0],"func_three": [0]},
	#{"item": 257,"control": "sel_equip","name": "RAGGY CLOTHES","desc": "Old raggy clothing.","amnt": 1,"max_amnt": 1,"min_amnt": 0,"weight": 1,"type": "EQUIP","func_one": [],"func_two": [],"func_three": []}
#]

var Database = {
	"null" = {
		"name" = "",
		"description" = "",
		"frame" = 0,
		"weight" = 0,
		"value" = 0
	},
	"leather bottle" = {
		"name" = "leather bottle",
		"description" = "A bottle made of leather.",
		"frame" = 1,
		"weight" = 0.5,
		"value" = 10
	}
}

static func equip():
	print("Equipping!!!")
