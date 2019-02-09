extends RigidBody

func _ready():
	mode = MODE_CHARACTER

func _process(delta):
	_handle_input(delta)


func _handle_input(delta):
	var motion = Vector3.ZERO
	#motion.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	motion.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_fw")
	if $RayCast.is_colliding(): # and (global_transform.origin - $RayCast.get_collision_point()).length() > 0.1:
#		print("raycast colliding here: " + $RayCast.get_collision_point())

		global_transform.basis.y = $RayCast.get_collision_normal()
		global_transform.basis = global_transform.basis.orthonormalized()
		global_transform.origin = $RayCast.get_collision_point()
	
	global_transform.origin += motion.z * global_transform.basis.z * delta * 4.0
	