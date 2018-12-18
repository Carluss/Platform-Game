extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _process(delta):
	if($leaver.hit==true):
		$Leaver00col/tiles_second_64.visible=false
		$Leaver00col/CollisionShape2D.disabled=true
		$Leaver00col/CollisionShape2D.position=Vector2(-3.469971,-80.103271)
	if($leaver2.hit==true):
		$Leaver01col/tiles_second_62.visible=false
		$Leaver01col/CollisionShape2D.disabled=true
		$Leaver01col/CollisionShape2D.position=Vector2(10.029953,70.693726)
	var at=get_node("Player").get("health")
	match at:
		0: 
			$Player/Camera2D/heart.visible=false
			$Player/Camera2D/heart2.visible=false
			$Player/Camera2D/heart3.visible=false
			$Player/Camera2D/heart4.visible=false
			$Player/Camera2D/heart5.visible=false
		1: 
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=false
			$Player/Camera2D/heart3.visible=false
			$Player/Camera2D/heart4.visible=false
			$Player/Camera2D/heart5.visible=false
			
		2:
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=true
			$Player/Camera2D/heart3.visible=false
			$Player/Camera2D/heart4.visible=false
			$Player/Camera2D/heart5.visible=false
			
		3:
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=true
			$Player/Camera2D/heart3.visible=true
			$Player/Camera2D/heart4.visible=false
			$Player/Camera2D/heart5.visible=false
			
		4:
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=true
			$Player/Camera2D/heart3.visible=true
			$Player/Camera2D/heart4.visible=true
			$Player/Camera2D/heart5.visible=false
			
		5:
			$Player/Camera2D/heart.visible=true
			$Player/Camera2D/heart2.visible=true
			$Player/Camera2D/heart3.visible=true
			$Player/Camera2D/heart4.visible=true
			$Player/Camera2D/heart5.visible=true
	if get_node("Node2D").get("bt")==true:
		$Node2D/Wall/tiles_second_33.visible=false
		$Node2D/Wall/CollisionShape2D.disabled=true
		$Node2D/Wall/CollisionShape2D.scale=Vector2(0,0)
	if get_node("Player").get("teleport")== true:
		get_node("Player").position=$Dead.global_position
	$Spikes/CollisionShape2D.disabled=false
	$Spikes/CollisionShape2D2.disabled=false
	$Spikes/CollisionShape2D3.disabled=false
	$Spikes/Col.disabled=false
	$Spikes/CollisionShape2D5.disabled=false
	$Spikes/CollisionShape2D4.disabled=false
	$Spikes/fsta1.disabled=false
	$Spikes/CollisionShape2D7.disabled=false
	$Spikes/CollisionShape2D6.disabled=false


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		get_node("Player").position=$Area2D2/dra1.global_position


func _on_Area2D2_body_entered(body):
	if "Player" in body.name:
		get_node("Player").position=$Area2D/dra.global_position


func _on_FStage_body_entered(body):
	if "Player" in body.name:
		get_node("Player").position=$FstageB/Fstageb.global_position


func _on_FstageB_body_entered(body):
	if "Player" in body.name:
		get_node("Player").position=$FStage/Fstage.global_position


func _on_Spikes_body_entered(body):
	if "Player" in body.name:
		$Spikes/CollisionShape2D.disabled=true
		$Spikes/CollisionShape2D2.disabled=true
		$Spikes/CollisionShape2D3.disabled=true
		$Spikes/Col.disabled=true
		$Spikes/CollisionShape2D5.disabled=true
		$Spikes/CollisionShape2D4.disabled=true
		$Spikes/fsta1.disabled=true
		$Spikes/CollisionShape2D7.disabled=true
		$Spikes/CollisionShape2D6.disabled=true
		body.spikes(1)
