extends Control


const SAVE_PATH := "user://save.json"

@onready var line_edit_0 := $HBox/Data/LineEdit0
@onready var line_edit_1 := $HBox/Data/LineEdit1
@onready var line_edit_2 := $HBox/Data/LineEdit2


func _ready() -> void:
	save_json()
	

func save_json() -> void:
	var data := {
		"line_edit_0": line_edit_0.text,
		"line_edit_1": line_edit_1.text,
		"line_edit_2": line_edit_2.text,
	}
	var json_data := JSON.stringify(data)
	var file_access := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file_access.store_line(json_data)
	file_access.close()


func load_json() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file_access := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_data := file_access.get_line()
	file_access.close()
	var data: Dictionary = JSON.parse_string(json_data)
	line_edit_0.text = data.line_edit_0
	line_edit_1.text = data.line_edit_1
	line_edit_2.text = data.line_edit_2
