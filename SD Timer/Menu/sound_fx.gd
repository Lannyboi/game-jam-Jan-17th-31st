extends HSlider


var bus = AudioServer.get_bus_index("sfx")


func _ready() -> void:
	value = Globalvars.SfxValue


func _value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(bus, new_value)
	Globalvars.SfxValue = new_value

	if new_value == -30:
		AudioServer.set_bus_mute(bus,true)
	else:
		AudioServer.set_bus_mute(bus,false)
