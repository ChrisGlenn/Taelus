extends Node
# PROVIDES DICE ROLLS FOR THE GAME
var rng = RandomNumberGenerator.new() # rng


func _ready():
    rng.randomize() # seed rng


func dice_roll(die, odds):
    # generate a random number against a dice roll
    var result = rng.randi_range(1,die)
    if result > odds:
        return [result - odds,"LOSE"] # return the difference
    elif result == odds:
        return [0,"EQUAL"] # return 0
    else:
        return [odds - result,"WIN"] # return the difference