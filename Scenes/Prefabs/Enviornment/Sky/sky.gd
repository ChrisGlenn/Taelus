extends CanvasModulate
# sky tests
const DAY_COLOR = Color("#ffffff") # color for the day time
const NIGHT_COLOR = Color("#0a0a0a") # color for the night time
var cycle_timer = 150 # 150 gets you all the way, baby
var cycles = 5 # checks the cycles (5 cycles)
var d_time = 0 # used to set color off time


func _ready():
	pass

func _process(delta):
	pass
	#if cycle_timer > 0:
		#cycle_timer -= Globals.timer_ctrl * delta
		#d_time += delta
		#color = DAY_COLOR.lerp(NIGHT_COLOR,sin(d_time))
