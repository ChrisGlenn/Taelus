extends Node
# PROVIDES DICE ROLLS FOR THE GAME
var rng = RandomNumberGenerator.new() # rng


func _ready():
    rng.randomize() # seed rng


func dice_roll(one, two):
    # generate a random number
    if one > 0:
        var result = rng.randi_range(0, one)
        return result
    else:
        print("ERROR: argument one not set...")
        get_tree().quit() # DEBUG quit game with error