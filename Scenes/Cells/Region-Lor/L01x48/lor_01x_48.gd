extends Node2D
# CELL 01X48 IN REGION LOR
@export_multiline var description = "" # used for if the player looks around
var load_chunks = false # if true it will iterate through and load the chunks below
var chunk_top; var chunk_right; var chunk_bottom; var chunk_left # chunks
var chunks_to_load = [
	"",
	"",
	"",
	"res://Scenes/Cells/Region-Lor/L00x48/lor_00x_48.tscn"
]


func _ready():
	Globals.current_region = "Lor" # set current region
	Globals.current_location = "Southern Lor" # set current location
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
					chunkT_instance.global_position = Vector2(0, global_position.y - 360)
					get_parent().add_child(chunkT_instance)
					chunk_top = chunkT_instance
					Globals.loaded_chunks.append(chunkT_instance)
				elif n == 1:
					# load right chunk
					var this_chunk = load(chunks_to_load[n])
					var chunkR_instance = this_chunk.instantiate()
					chunkR_instance.global_position = Vector2(global_position.x + 640, 0)
					get_parent().add_child(chunkR_instance)
					chunk_right = chunkR_instance
					Globals.loaded_chunks.append(chunkR_instance)
				elif n == 2:
					# load bottom chunk
					var this_chunk = load(chunks_to_load[n])
					var chunkB_instance = this_chunk.instantiate()
					chunkB_instance.global_position = Vector2(global_position.y + 360, 0)
					get_parent().add_child(chunkB_instance)
					chunk_bottom = chunkB_instance					
					Globals.loaded_chunks.append(chunkB_instance)
				elif n == 3:
					# load left chunk
					var this_chunk = load(chunks_to_load[n])
					var chunkL_instance = this_chunk.instantiate()
					chunkL_instance.global_position = Vector2(global_position.x - 640, 0)
					get_parent().add_child(chunkL_instance)
					chunk_left = chunkL_instance					
					Globals.loaded_chunks.append(chunkL_instance)
		load_chunks = false # chunks are done loading


func _process(_delta):
	chunk_loading()


func swap_active(direction):
	# set the active scene and have them load their respective chunks
	if direction == "UP":
		if chunk_top:
			Globals.active_scene = chunk_top
			print(Globals.active_scene)
	elif direction == "RIGHT":
		if chunk_right:
			Globals.active_scene = chunk_right
			print(Globals.active_scene)
	elif direction == "DOWN":
		if chunk_bottom:
			Globals.active_scene = chunk_bottom
			print(Globals.active_scene)
	elif direction == "LEFT":
		if chunk_left:
			Globals.active_scene = chunk_left
			print(Globals.active_scene)

func chunk_loading():
	# load the local chunks
	if load_chunks:
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
		if Globals.cam_move_count == 4:
			for m in Globals.loaded_chunks.size():
				var temp = Globals.loaded_chunks[m]
				if temp != chunk_top or temp != chunk_right or temp != chunk_bottom or temp != chunk_left:
					# print(Globals.loaded_chunks[m])
					Globals.loaded_chunks.remove_at(m) # remove
			Globals.cam_move_count = 0 # reset cam_move_count to zero
		load_chunks = false # stop the chunk loading
