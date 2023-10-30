extends Node3D

var unity_attacked: bool = false

func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	rotate_y(0.01)
	rotate_x(0.01)
	rotate_z(0.01)

	


func _on_area_3d_body_entered(body):
	print("Unity attacked: Area Entered 1")
	$"3DGodotRobot/AnimationPlayer".play("Hurt")
	unity_attacked = true
	global_position.x += 0.1
	$StateChart.send_event("robot_attack")
