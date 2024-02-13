extends Node
# GLOBAL VARIABLES
# GAME
var new_game: bool = true # sets a new game or not

# LOR
# time/day
var year: int = 198 # defaults to 198
var month: int = 1 # defaults to 1
var day: int = 1 # defaults to 1
var hour: int = 9 # defaults to 9am
var minutes: int = 0 # defaults to 0 resets at 60
var seconds: int = 0 # starts at 0 resets at 60
var month_max_days = [28,22,26,29,30,24,26,24,25,22]
var seasons = ["Winter","Spring","Summer","Fall"]
var days_in_game = 0

# SYSTEM
var timer_ctrl: int = 100 # timer control
