extends CanvasModulate
# THE SKY
# day/night cycle that runs for the game
# NOTE: save the color to a global for game saving???
const DAY_COLOR = Color("#ffffff") # color for the day time
const NIGHT_COLOR = Color("#0a0a0a") # color for the night time
var cycle_timer = 30 # 150 gets you all the way, baby so 5 counts of 30 seconds each
var cycles = 5 # checks the cycles (5 cycles)
var dawn_dusk = [6,17] # sets time for dawn dusk winter/fall: 6:30am to 5:30pm spring/summer: 5:30 to 7:30
var d_time = 0 # used to set color off time


func _ready():
	set_season() # set the season 

func _process(delta):
	# the game starts off during the day time SO start this off looking for night...
	if Globals.hour == dawn_dusk[0]:
		# sunrise
		# check the cycles against the minutes, run a 
		pass


func set_season():
	if Globals.season == 0 || Globals.season == 3:
		# winter/spring
		dawn_dusk = [6,17]
	elif Globals.season == 1 || Globals.season == 2:
		# spring/summer
		dawn_dusk = [5,9] # 9 for testing 17 for game
