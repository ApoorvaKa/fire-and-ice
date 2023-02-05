extends KinematicBody2D

var speed: float = 200
var acceleration: float = 2000 # this is 10 times the speed
var friction: float = acceleration / speed

var velocity: Vector2 = Vector2()

func _process(delta: float) -> void:
	apply_traction(delta)
	apply_friction(delta)

func _physics_process(delt: float) -> void:
	velocity = move_and_slide(velocity)
	
func apply_traction(delta: float) -> void:
	var traction: Vector2 = Vector2()
	
	if (Input.is_action_pressed("left")):
		traction.x -= 1
	if (Input.is_action_pressed("right")):
		traction.x += 1
	if (Input.is_action_pressed("up")):
		traction.y -= 1
	if (Input.is_action_pressed("down")):
		traction.y += 1
	
	traction = traction.normalized()
	
	velocity += traction * acceleration * delta
	
func apply_friction(delta: float) -> void:
	velocity -= velocity * friction * delta
