extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		print("RayCast3D - Collision detected!")
		var object = get_collider()
		$"../StateChart".send_event("robot_noticed")
		enabled = false
