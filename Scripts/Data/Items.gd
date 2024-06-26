extends Node
# ITEMS IN THE GAME!!!

var items = {
	"Leather Bottle" : {"finder": "LBE","name" : "Leather Bottle","description" : "A small empty bottle made of leather.","frame" : 1,"weight" : 0.2,"value" : 2,"amnt" : 0,"max_amnt" : 5,"min_amnt" : -4,"stackable" : false,"equip": false,"equipped": false,"equip_slot": "null","type" : "CONSUME","hud_mode" : "sel_drink","func_one" : [0],"func_two" : [0],"func_three" : [0]},
	"Wood Bowl(Empty)" : {"finder": "WBE","name": "Wooden Bowl","description": "An empty wooden bowl.","frame" : 2,"weight" : 0.3,"value" : 5,"amnt" : 1,"max_amnt" : 99,"min_amnt" : 1,"stackable" : true,"equip": false,"equipped": false,"equip_slot": "null","type" : "EMPTY","hud_mode" : "sel_inv_default","func_one" : [0],"func_two" : [0],"func_three" : [0]},
	"Rags" : {"finder": "RAG","name": "Cloth Rags","description": "Some old ragged clothing","frame" : 257,"weight" : 1,"value" : 2,"amnt" : 1,"max_amnt" : 1,"min_amnt" : 1,"stackable" : false,"equip": true,"equipped": false,"equip_slot": "armor","type" : "EQUIP","hud_mode" : "sel_equip","func_one" : [0],"func_two" : [0],"func_three" : [0]},
	"Red Apple" : {"finder": "RAPPLE","name": "Red Apple","description": "A juicy red Apple.","frame" : 71,"weight" : 0.3,"value" : 5,"amnt" : 1,"max_amnt" : 99,"min_amnt" : 1,"stackable" : true,"equip": false,"equipped": false,"equip_slot": "null","type" : "CONSUME","hud_mode" : "sel_eat","func_one" : [0],"func_two" : [0],"func_three" : [0]},
	"Chestnut Wood" : {"finder": "CHESWOOD","name": "Chestnut Wood","description": "A small log from a Chestnut tree.","frame" : 516,"weight" : 1,"value" : 5,"amnt" : 1,"max_amnt" : 99,"min_amnt" : 1,"stackable" : true,"equip": false,"equipped": false,"equip_slot": "null","type" : "CONSUME","hud_mode" : "sel_eat","func_one" : [0],"func_two" : [0],"func_three" : [0]}
}

# UPDATES TO BE MADE
# Chestnut Wood frame needs to be updated to correct one