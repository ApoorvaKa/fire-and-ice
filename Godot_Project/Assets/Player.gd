extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	position.x = clamp(position.x, 0, screen_size.x) # clamp to keep it within the screen
	position.y = clamp(position.y, 0, screen_size.y) # clamp to keep it within the screen
