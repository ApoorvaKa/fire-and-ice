extends KinematicBody2D

var speed: float = 300
var acceleration: float = 2000 # this is 10 times the speed
var friction: float = acceleration / speed
var squash: bool = false
var smooth_motion: bool = false
var dash_status: bool = false
var can_smash: bool = false

var velocity: Vector2 = Vector2()
var temp_velocity: Vector2 = Vector2()

func _process(delta: float) -> void:
	if smooth_motion:
		apply_traction(delta)
		apply_friction(delta)
	else:
		unsmooth_motion(delta)
	if squash:
		resize(delta)
	if dash_status:
		if Input.is_action_pressed("dash"):
			apply_dash()
		
		
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
	scale.x = velocity.length()/600 + 1

func apply_dash():
	temp_velocity = velocity
	if smooth_motion:
		velocity = velocity*5
	else:
		velocity = velocity*12
	$Timer.start()
	
func _on_Timer_timeout():
	velocity = temp_velocity



func _on_Obstacle_Area_body_entered(body):
	if(can_smash == true):
		get_node("/root/Main/Obstacle/Sprite").texture = load("res://art/obstacle_cracked.png")
		get_node("/root/Main/AudioStreamPlayer").stream = load("res://sounds/obstacle_breaking.mp3")
		get_node("/root/Main/AudioStreamPlayer").play()
		



		
		

