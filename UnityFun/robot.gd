extends Node3D

var unity_attacked : bool = false
var unity_position : Node3D = null

@onready var happy_music:AudioStreamPlayer3D = $"../happy_music"
@onready var angry_music:AudioStreamPlayer3D = $"../angry_music"

# We've entered the idle state
func _on_idle_state_entered():
	$"3DGodotRobot/AnimationPlayer".play("Idle")

# We are now walking
func _on_walking_state_entered():
	$"3DGodotRobot/AnimationPlayer".play("Run")
	happy_music.play()

# While walking update the position, moving toward the screen
func _on_walking_state_physics_processing(delta):
	global_position.z += 2 * delta

# We've reached the wave point area
# switch states to wave
func _on_wave_point_area_entered(area):
	print("Wave point entered")
	$StateChart.send_event("wave")

# We've entered the wave state,
# Wave and move to the unity attack state
func _on_wave_state_entered():
	print("Wave state entered")
	$"3DGodotRobot/AnimationPlayer".play("Emote1")
	$StateChart.send_event("unity_attack")

# While we are waving, unity attacks!
func _on_unity_attack_state_entered():
	happy_music.stop()
	angry_music.play()
	pass # Replace with function body.

# begin attacking the Godot robot by moving our
# body towards the robot!
func _on_unity_attack_state_physics_processing(delta):
	if unity_attacked == false:
		global_position.x -= 1 * delta

# We've been hurt by unity
#func _on_area_3d_area_entered(area):
#	print("Unity attacked: Area Entered 1")
#	$"3DGodotRobot/AnimationPlayer".play("Hurt")
#	unity_attacked = true
#	global_position.x += 0.1
#	$StateChart.send_event("robot_attack")
#	$"3DGodotRobot".look_at(area.global_transform.origin,Vector3.UP)

# We're not going to take this sitting down	
func _on_robot_attack_state_entered():
	$"3DGodotRobot/AnimationPlayer".play("Attack1")
	global_position.x += 0.1






