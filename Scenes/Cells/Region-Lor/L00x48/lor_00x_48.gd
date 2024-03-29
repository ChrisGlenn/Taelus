extends Node2D
# CELL 00X48 IN REGION LOR
@onready var ROOF = $Roofs
@onready var BLACKOUT = $BlackOut
@export_multiline var description = "" # used for if the player looks around
var load_chunks = false # if true it will iterate through and load the chunks below
var chunk_top; var chunk_right; var chunk_bottom; var chunk_left # chunks
var chunks_to_load = [
	"",
	"res://Scenes/Cells/Region-Lor/L01x48/lor_01x_48.tscn",
	"",
	""
]


func _ready():
	Globals.current_region = "Lor" # set current region
	Globals.current_location = "S. Watchtower" # set current location
	# if the load_chunks bool is true then iterate through the chunks_to_load array and
	# load the chunks around this level
	if load_chunks:
		# load the cooresponding chunks (can I spell?)
		for n in chunks_to_load.size():
			if chunks_to_load[n].length() > 0:
				# iterate through and if there is something there then load the level
				# DON'T SET IT'S LOAD_CHUNKS TO TRUE FOR THE LOVE OF GOD
				if n == 0:
					# load top chunk
					var this_chunk = load(chunks_to_load[n])
					var chunkT_instance = this_chunk.instantiate()
					chunkT_instance.global_position = Vector2(global_position.y - 360, 0)
					get_parent().add_child(chunkT_instance)
					chunk_top = chunkT_instance
					Globals.loaded_chunks.append(chunkT_instance)
				elif n == 1:
					# load right chunk
					var this_chunk = load(chunks_to_load[n])
					var chunkR_instance = this_chunk.instantiate()
					chunkR_instance.global_position = Vector2(global_position.x + 640, 0)
					get_parent().add_child(chunkR_instance)
					chunk_top = chunkR_instance
					Globals.loaded_chunks.append(chunkR_instance)
				elif n == 2:
					# load bottom chunk
					var this_chunk = load(chunks_to_load[n])
					var chunkB_instance = this_chunk.instantiate()
					chunkB_instance.global_position = Vector2(global_position.y + 360, 0)
					get_parent().add_child(chunkB_instance)
					chunk_top = chunkB_instance					
					Globals.loaded_chunks.append(chunkB_instance)
				elif n == 3:
					# load left chunk
					var this_chunk = load(chunks_to_load[n])
					var chunkL_instance = this_chunk.instantiate()
					chunkL_instance.global_position = Vector2(global_position.x - 640, 0)
					get_parent().add_child(chunkL_instance)
					chunk_top = chunkL_instance					
					Globals.loaded_chunks.append(chunkL_instance)
		# clear out unneeded chunks from chunks_loaded Global
		for m in Globals.loaded_chunks.size():
			var temp = Globals.loaded_chunks[m]
			if temp != chunk_top or temp != chunk_right or temp != chunk_bottom or temp != chunk_left:
				# print(Globals.loaded_chunks[m])
				Globals.loaded_chunks.remove_at(m) # remove


func _process(_delta):
	# check if the player is inside of an interior (the guardtower) and then show/hide the
	# roof and blackout depending on the Globals interior status
	if Globals.interior:
		ROOF.visible = false # hide the roof
		BLACKOUT.visible = true # show the blackout
	else:
		ROOF.visible = true # show the roof
		BLACKOUT.visible = false # hide the blackout


func chunk_loading():
	# load the local chunks
	for n in chunks_to_load.size():
		if chunks_to_load[n].length() > 0:
			# iterate through and if there is something there then load the level
			# DON'T SET IT'S LOAD_CHUNKS TO TRUE FOR THE LOVE OF GOD
			if n == 0:
				# load top chunk
				var this_chunk = load(chunks_to_load[n])
				var chunkT_instance = this_chunk.instantiate()
				chunkT_instance.global_position = Vector2(global_position.y - 360, 0)
				get_parent().add_child(chunkT_instance)
				chunk_top = chunkT_instance
				Globals.loaded_chunks.append(chunkT_instance)
			elif n == 1:
				# load right chunk
				var this_chunk = load(chunks_to_load[n])
				var chunkR_instance = this_chunk.instantiate()
				chunkR_instance.global_position = Vector2(global_position.x + 640, 0)
				get_parent().add_child(chunkR_instance)
				chunk_top = chunkR_instance
				Globals.loaded_chunks.append(chunkR_instance)
			elif n == 2:
				# load bottom chunk
				var this_chunk = load(chunks_to_load[n])
				var chunkB_instance = this_chunk.instantiate()
				chunkB_instance.global_position = Vector2(global_position.y + 360, 0)
				get_parent().add_child(chunkB_instance)
				chunk_top = chunkB_instance					
				Globals.loaded_chunks.append(chunkB_instance)
			elif n == 3:
				# load left chunk
				var this_chunk = load(chunks_to_load[n])
				var chunkL_instance = this_chunk.instantiate()
				chunkL_instance.global_position = Vector2(global_position.x - 640, 0)
				get_parent().add_child(chunkL_instance)
				chunk_top = chunkL_instance					
				Globals.loaded_chunks.append(chunkL_instance)
	# clear out unneeded chunks from chunks_loaded Global
	for m in Globals.loaded_chunks.size():
		var temp = Globals.loaded_chunks[m]
		if temp != chunk_top or temp != chunk_right or temp != chunk_bottom or temp != chunk_left:
			# print(Globals.loaded_chunks[m])
			Globals.loaded_chunks.remove_at(m) # remove