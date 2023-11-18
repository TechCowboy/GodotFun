extends Node3D

var animationNode = null
var robot_target:NavigationAgent3D = null
var unity_target:NavigationAgent3D = null
var wave_target :Marker3D          = null
var flee_target :Marker3D		   = null

var robot_speed = 1
var robot_height
var unity_speed = 0.5
var unity_height

var been_hurt = false

# Called when the node enters the scene tree for the first time.
func _ready():
	robot_target = $player/NavigationAgentRobot
	unity_target = $Unity/NavigationAgentUnity
	wave_target  = $WavePoint
	flee_target  = $FleePoint

	animationNode = get_node("player/3DGodotRobot/AnimationPlayer")


################ IDLE  #############################
func _on_idle_state_entered():
	print("idle state entered")
	animationNode.play("Idle")
	robot_height = 1.6
	print("robot height: ", robot_height)
	
	
################# RUN ############################

func _on_run_state_entered():
	print("run state entered")
	animationNode.play("Run")
	robot_target.target_position = wave_target.global_position


func _on_run_state_physics_processing(delta):
	if robot_target == null:
		return
		
	var direction = Vector3()
	var movement_delta = robot_speed * delta
	var next_path_position: Vector3 = robot_target.get_next_path_position()
	var current_agent_position: Vector3 = global_position
	var new_velocity: Vector3 = (next_path_position - current_agent_position).normalized() * movement_delta

	#$player.global_position = $player.global_position.move_toward($player.global_position *  new_velocity, movement_delta)
	$player.global_position - $player.global_position.move_toward(next_path_position, movement_delta)
#$player.global_position.y = robot_height
	
	if robot_target.is_navigation_finished():
		$StateChart.send_event("Wave")
	
	
func _on_run_state_exited():
	pass
	
#############################################



##################################################

func _on_wave_state_entered():
	print("wave state entered")
	animationNode.play("Emote1")
		
####################################################


func _on_sneak_state_entered():
	print("Sneak attack initiated")
	unity_height = $Unity.global_position.y
	

func _on_sneak_state_physics_processing(delta):
	if unity_target == null:
		return
		
	var direction = Vector3()
	unity_target.target_position = $player.global_position
	unity_target.debug_enabled = true
	
	$Unity.global_position = lerp($Unity.global_position, robot_target.get_next_path_position(), unity_speed * delta)
	$Unity.global_position.y = unity_height
	
func _on_wave_state_physics_processing(delta):
	pass

func _on_area_3d_2_area_entered(area):
	if ! been_hurt:
		$StateChart.send_event("Hurt")


func _on_hurt_state_entered():
	print("robot height2: ", robot_height)
	$player.global_position.y = robot_height
	print("Hurt")
	animationNode.play("Hurt")
	print("robot height3: ", robot_height)
	$StateChart.send_event("RunAway")



func _on_attack_state_entered():
	$player.global_position.y = robot_height
	print("Attack")
	animationNode.play("Attack")
	

func _on_run_away_state_entered():
	print("Run Away")
	unity_target.target_position = flee_target.global_position
	


func _on_run_away_state_physics_processing(delta):
	$Unity.global_position = lerp($Unity.global_position, robot_target.get_next_path_position(), unity_speed * delta)

	$Unity.global_position.y = unity_height


func _on_attack_state_physics_processing(delta):
	if ! animationNode.is_playing():
		animationNode.play("Attack")
