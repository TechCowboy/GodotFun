extends Node3D


func _on_idle_state_entered():
	$"3DGodotRobot/AnimationPlayer".play("Idle")

func _on_walking_state_entered():
	$"3DGodotRobot/AnimationPlayer".play("Run")

func _on_walking_state_physics_processing(delta):
	global_position.z += 2 * delta

func _on_turning_state_entered():
	print("Turning state entered")
	$"3DGodotRobot/AnimationPlayer".play("Emote1")
	$StateChart.send_event("unity_attack")

func _on_turning_point_area_entered(area):
	print("Area Entered")
	$StateChart.send_event("noticed_unity")

func _on_turning_point_body_entered(body):
	print("Body Entered")
	$StateChart.send_event("noticed_unity")

func _on_unity_attack_state_entered():
	pass # Replace with function body.
	# attack robot

func _on_unity_attack_state_physics_processing(delta):
	global_position.x -= 1 * delta

