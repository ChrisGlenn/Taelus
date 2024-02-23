extends Node
# EVENTS
# this holds the functions that create events in the game!!!


func _ready():
    print(str(Dice.dice_roll(10, 30)))

func weather(season, _odds, _effect):
    # season = current season
    # odds[seasonal_odds] = the odds set for the current year
    # effect = rain, snow, wind, sun
    # this function updates the weather
    # it takes in some parameters then does a 'dice roll' which will return a number
    # then updates the Globals for the Sky.tscn scene to read and update
    if !Globals.weather_updated:
        # if the weather isn't updated then run the event
        match season:
            0:
                # winter
                # roll the dice with the odds to see if there will be an event
                # based on the odds set
                Globals.weather_updated = true # weather is updated
            1:
                # spring
                pass
            2:
                # summer
                pass
            3:
                # fall
                pass