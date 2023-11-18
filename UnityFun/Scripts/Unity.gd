extends Node3D

var unity_attacked: bool = false

func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	rotate_y(0.01)
	rotate_x(0.01)
	rotate_z(0.01)

	

