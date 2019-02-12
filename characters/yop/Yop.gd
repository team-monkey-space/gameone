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

		global_transform.basis.y = $RayCast.get_collision_normal().linear_interpolate( global_transform.basis.y, 0.3 )
		global_transform.basis = global_transform.basis.orthonormalized()
		global_transform.origin = $RayCast.get_collision_point()
	global_transform.origin += motion.z * global_transform.basis.z * delta * 4.0
	
	var angle = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	angle = sign(angle)
	global_transform.basis = global_transform.basis.rotated(
		global_transform.basis.y,
		angle * deg2rad(30.0) * delta
		)
	var camera_rotation = Input.get_action_strength("look_left") - Input.get_action_strength("look_right")
	camera_rotation = sign(camera_rotation)
	var spring = $SpringArm
	spring.transform.basis = spring.transform.basis.rotated( Vector3(0,1,0) , delta * deg2rad(30)  * camera_rotation)