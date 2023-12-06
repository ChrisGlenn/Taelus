extends StaticBody2D
# TREE
# Tracks the tree's status. If it's cut down keep track of when it grows back.
@export var id : String = ""
var status = 0 # 0 is full 1 is cut
var hit_points = 30 # tree's HP


func _ready():
	# check if there is an entry for this tree in the tree array. If so then show as cut.
	if Globals.cut_trees.size() > 0:
		# do a for loop looking for the ID for this instance
		# if it's found then check the regrow date and set the sprite based
		# on these two numbers
		pass

func hit():
	# player has hit the tree with an axe...
	pass

func cut_down():
	# this tree has been cut down
	pass
