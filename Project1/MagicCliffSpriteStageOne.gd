extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _process(delta):
	if get_node("Player").get("teleport")== true:
		get_node("Player").position=$Dead.global_position
	


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
