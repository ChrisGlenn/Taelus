extends ColorRect
# FADE IN
# simple script that fades in and deletes self when finished
# will also allow the player to take control again
@onready var ANIMATOR = $AnimFadeIn


func _ready():
	ANIMATOR.play("fade_in") # start animation on load

func _on_anim_fade_in_animation_finished(_anim_name):
	Globals.can_play = true # return control to player
	queue_free() # delete self after loading in
