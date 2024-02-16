class_name Items

const Data = {
	"NULL" : {
		"name" : "null",
		"description" : "",
		"frame" : 0,
		"weight" : 0,
		"value" : 0,
		"amnt" : 0,
		"max_amnt" : 0,
		"stackable" : false,
		"hud_mode" : ""
	},
	"Leather Bottle" : {
		"name" : "Leather Bottle",
		"description" : "A small empty bottle made of leather.",
		"frame" : 1,
		"weight" : 0.2,
		"value" : 2,
		"amnt" : 0,
		"max_amnt" : 1,
		"min_amnt" : -4,
		"stackable" : true,
		"type" : "CONSUME",
		"hud_mode" : "sel_drink",
		"func_one" : [0],
		"func_two" : [0],
		"func_three" : [0]
	},
	"Water Bottle" : {
		"name" : "Water Bottle",
		"description" : "A small bottle made of leather that's full of water.",
		"frame" : 1,
		"weight" : 1,
		"value" : 2,
		"amnt" : 1,
		"max_amnt" : 5,
		"min_amnt" : -4,
		"stackable" : true,
		"type" : "CONSUME",
		"hud_mode" : "sel_drink",
		"func_one" : [0],
		"func_two" : [0],
		"func_three" : [0]
	},
	"Wine Bottle" : {
		"name" : "Wine Bottle",
		"description" : ""
	}
}

#var items = [
	#{"item": 0},
	#{"item": 1,"control": "sel_drink","name": "WATERSKIN","desc": "A waterskin made of leather.","amnt": 5,"max_amnt": 5,"min_amnt": -4,"weight": 0.2,"type": "CONSUME","func_one": [1,50.0],"func_two": [0],"func_three": [0]},
	#{"item": 2,"control": "sel_eat","name": "RATION","desc": "A bowl of food.","amnt": 1,"max_amnt": 99,"min_amnt": 0,"weight": 0.5,"type": "CONSUME","func_one": [1,30.0],"func_two": [0],"func_three": [0]},
	#{"item": 257,"control": "sel_equip","name": "RAGGY CLOTHES","desc": "Old raggy clothing.","amnt": 1,"max_amnt": 99,"min_amnt": 0,"weight": 1,"type": "EQUIP","func_one": [],"func_two": [],"func_three": []}
#] 
