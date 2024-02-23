extends Node
# PROVIDES DICE ROLLS FOR THE GAME
var rng = RandomNumberGenerator.new() # rng


func _ready():
    rng.randomize() # seed rng