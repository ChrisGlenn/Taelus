extends Node2D
# TAELUS
# the 'overworld' controller
@onready var PLAYER = $Player
var chunk # the chunk to load


func _ready():
	# load the initial location for the player
	for n in Chunks.chunk_paths.size():
		if Chunks.chunk_paths[n]["location"] == Globals.current_location:
			# if n is the location that the player is in then spawn it
			chunk = load(Chunks.chunk_paths[n]["path"])
			var chunk_instance = chunk.instantiate()
			chunk_instance.load_chunks = true # tell it to load the chunks around it
			add_child(chunk_instance)
			Globals.loaded_chunks.append(chunk_instance)
			break