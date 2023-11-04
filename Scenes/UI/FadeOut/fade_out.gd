extends ColorRect
# FADE OUT
# fade out scene, if set, will also load a new level
@onready var ANIMATOR = $AnimFadeOut
@export var load_scene : bool = false # load scene
var level_to_load = "" # level to load


func _ready():
	ANIMATOR.play("fade_out") # start fade out animation

func _on_anim_fade_out_animation_finished(_anim_name):
	if level_to_load.length() > 0:
		# if there is a set level to load then load it
		var _change_scene = get_tree().change_scene_to_file(level_to_load)
		queue_free() # delete self
	else:
		print("ERROR: level_to_load not set in FadeOut...")
