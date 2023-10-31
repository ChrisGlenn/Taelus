extends StaticBody2D
# TREE
# Tracks the tree's status. If it's cut down keep track of when it grows back.
@export var id : int = 0
var status = 0 # 0 is full 1 is cut


func _ready():
	# check if there is an entry for this tree in the tree array. If so then show as cut.
	pass
