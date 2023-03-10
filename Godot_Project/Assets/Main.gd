extends Node2D

var dangerous_fire: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dangerous_fire:
		warmth()

func _on_Menu_toggle_dangerous_fire():
	dangerous_fire = !dangerous_fire

func _on_Menu_toggle_trail():
	var curr = $Player/Trail.visible
	$Player/Trail.visible = !curr

func _on_Menu_toggle_squash():
	var curr = $Player.squash
	$Player.squash = !curr

func _on_Menu_toggle_smooth_motion():
	var curr = $Player.smooth_motion
	$Player.smooth_motion = !curr
	print($Player.smooth_motion)
	
func warmth() -> void:
	if $Player.position.distance_to($Fire.position) < 140:
		var reverse_dist: float = (120 - $Player.position.distance_to($Fire.position))
		var heat: float = reverse_dist/120
		if heat > 0.3:
			heat = 0.3
		$CanvasLayer/ColorRect.color.a = heat
		if $Player.position.distance_to($Fire.position) < 120:
			$Camera.position = Vector2(512 + rand_range(-0.2 * reverse_dist, 0.2 * reverse_dist), 300 + rand_range(-0.2 * reverse_dist, 0.2 * reverse_dist))
		else:
			$Camera.position.x = 512
			$Camera.position.y = 300

func _on_Menu_toggle_dash():
	var curr = $Player.dash_status
	$Player.dash_status = !curr


func _on_Menu_toggle_smash_obstacles():
	var curr = $Player.can_smash
	$Player.can_smash = !curr


func _on_Obstacle_Timer_timeout():
	get_node("/root/Main/Camera/").position.x = 513
	get_node("/root/Main/Camera/").position.y = 300
	
