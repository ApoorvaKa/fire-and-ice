extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	warmth()

func _on_Menu_toggle_trail():
	var curr = $Player/Trail.visible
	$Player/Trail.visible = !curr

func _on_Menu_toggle_squash():
	var curr = $Player.squash
	$Player.squash = !curr

func warmth() -> void:
	print($Player.position.distance_to($Fire.position))
	if $Player.position.distance_to($Fire.position) < 140:
		var heat: float = (120 - ($Player.position - $Fire.position).length())/120
		if heat > 0.7:
			heat = 0.7
		$CanvasLayer/ColorRect.color.a = heat
		if $Player.position.distance_to($Fire.position) < 120:
			Camera2D
