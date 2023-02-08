extends KinematicBody2D

var speed: float = 200
var acceleration: float = 2000 # this is 10 times the speed
var friction: float = acceleration / speed
var squash: bool = false
var smooth_motion: bool = false

var velocity: Vector2 = Vector2()

func _process(delta: float) -> void:
	if smooth_motion:
		apply_traction(delta)
		apply_friction(delta)
	else:
		unsmooth_motion(delta)
	if squash:
		resize(delta)
		
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

func unsmooth_motion(delta: float) -> void:
	velocity.x = 0
	velocity.y = 0
	if (Input.is_action_pressed("left")):
		velocity.x -= 100
	if (Input.is_action_pressed("right")):
		velocity.x += 100
	if (Input.is_action_pressed("up")):
		velocity.y -= 100
	if (Input.is_action_pressed("down")):
		velocity.y += 100

func resize(delta: float) -> void:
	rotation = velocity.angle()
	scale.x = velocity.length()/1000 + 1
