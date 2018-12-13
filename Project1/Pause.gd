extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		for button in $VBox/HBox/Buttons.get_children():
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
			var new_pause_state = not get_tree().paused
			get_tree().paused = new_pause_state
			get_tree().change_scene(scene_to_load)
