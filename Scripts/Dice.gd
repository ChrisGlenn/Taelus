extends Node
# PROVIDES DICE ROLLS FOR THE GAME
var rng = RandomNumberGenerator.new() # rng


func _ready():
    rng.randomize() # seed rng


func dice_roll(die, odds):
    # generate a random number against a dice roll
    var result = rng.randi_range(1,die)
    if result > odds:
        return [odds - result,"lose"] # return the difference
    elif result == odds:
        return [0,"equal"] # return 0
    else:
        return [result - odds,"win"] # return the difference