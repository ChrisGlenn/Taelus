extends Node
# ALPHA FARM CONTROLLER
# the alpha farm is an alpha version of...a farm that will be in the game. This is where I can work out
# NPC coding/planning. This is a small farm that may or may not have a family on it. It starts out with a 
# single male farmer who grows crops. Animals will come later...
@onready var CARROTS = preload("res://Scenes/Prefabs/Crops/Carrot/carrot.tscn")
var RNG = RandomNumberGenerator.new()
