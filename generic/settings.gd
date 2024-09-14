extends Node
class_name Settings

var fullscreen: bool
var volume: float

var bus_index: int

func _init() -> void:
	load_settings()
	bus_index = AudioServer.get_bus_index("Master")
		
func load_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	var err = config.load("user://settings.cfg")

	if err == 7:
		print(err)
		_create_settings()
		return
	
	fullscreen = config.get_value("Settings", "fullscreen", DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	volume = config.get_value("Settings", "volume", db_to_linear(AudioServer.get_bus_volume_db(bus_index)))
	
	
	save_fullscreen(fullscreen)
	save_volume(volume)

func _create_settings():
	var config: ConfigFile = ConfigFile.new()
	config.set_value("Settings", "fullscreen", DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	config.set_value("Settings", "volume", db_to_linear(AudioServer.get_bus_volume_db(bus_index)))
	config.save("user://settings.cfg")
	load_settings()
	
	
func save_fullscreen(new_fullscreen: bool) -> void:
	if new_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	
	fullscreen = new_fullscreen
	
	save()

func save_volume(new_volume: float):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_volume))
	
	volume = new_volume
	
	save()
	
func save():
	var config: ConfigFile = ConfigFile.new()
	config.set_value("Settings", "fullscreen", fullscreen)
	config.set_value("Settings", "volume", volume)
	config.save("user://settings.cfg")
