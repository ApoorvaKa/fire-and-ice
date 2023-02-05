extends Line2D

export var max_trail_len = 80
var point_velocity = Vector2()

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	
	# get the last poisition player was at and add that to the trail
	point_velocity = get_parent().global_position
	add_point(point_velocity)
	
	# when trail is longer than maximum trail length remove oldest point
	while get_point_count() > max_trail_len:
		remove_point(0)
	
	
