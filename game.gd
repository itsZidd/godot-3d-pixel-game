extends Control

@export var target: Character = null
@export var camera: Camera3D = null
@export var render_size: TextureRect = null
@export var viewport: SubViewport = null
@export var pixel_size := 2.0
@export var building_file: PackedScene
@export var building_smoke_file: PackedScene
@export var main_scene: Node3D
@export var pointer: Node3D

signal input_event(event: InputEvent)


enum ClickMode {None, Build}


var _clicked_at := Vector2.ZERO
var _mouse_pos := Vector2.ZERO
var _click_mode := ClickMode.None
var _clicked := false
var _window_size := Vector2(1280, 720)
var _pointer_height := 0.25

func _ready() -> void:
	get_tree().root.size_changed.connect(_on_window_resize)
	_on_window_resize()

func _on_window_resize() -> void:
	_window_size = get_tree().root.size

	var scaled_size = _window_size / pixel_size
	var ortho_size = scaled_size.y / 360.0 * 10.0
	camera.size = ortho_size
	viewport.size = scaled_size
	RenderingServer.global_shader_parameter_set("screen_size", scaled_size)