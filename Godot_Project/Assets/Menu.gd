extends CanvasLayer

signal toggle_trail
signal toggle_squash
signal toggle_smooth_motion

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Trail_toggled(button_pressed):
	emit_signal("toggle_trail")

func _on_Squash_toggled(button_pressed):
	emit_signal("toggle_squash")

func _on_Smooth_Motion_toggled(button_pressed):
	emit_signal("toggle_smooth_motion")
