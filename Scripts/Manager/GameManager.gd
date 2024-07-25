extends Node

enum GameStates {
	Gameplay = 0,
	Pause,
	Intro,
	Outro,
}

var _paused: bool = false

@onready
var _pause_display: Label = $UI/PauseDisplay

@onready
var _hud: Control = $UI/HUD

@onready
var _fade_over: ColorRect = $UI/FadeOver

@onready
var _intro_display: Control = $UI/HUD/IntroDisplay

var _is_fading: bool = false


func _ready() -> void:
	GlobalEvents.player_death.connect(_on_player_death)
	intro()


func _on_player_death(player: CharacterBody2D) -> void:
	outro(player.score_counter)


func intro() -> void:
	_is_fading = true
	get_tree().paused = true

	_fade_over.process_mode = Node.PROCESS_MODE_ALWAYS
	await _fade_over.fade_in()

	_intro_display.process_mode = Node.PROCESS_MODE_ALWAYS
	await _intro_display.play()

	get_tree().paused = false
	_is_fading = false


func outro(score_counter: ScoreCounter) -> void:
	await get_tree().create_timer(1.0, false).timeout
	if _check_highscore(score_counter.score):
		await get_tree().create_timer(1.0, false).timeout

	_is_fading = true
	get_tree().paused = true

	_fade_over.process_mode = Node.PROCESS_MODE_ALWAYS
	await _fade_over.fade_out()

	get_tree().paused = false
	_is_fading = false

	get_tree().change_scene_to_packed(Globals.GAME_SCENE)


func _check_highscore(score: int) -> bool:
	if score > Globals.highscore:
		Globals.highscore = score
		GlobalEvents.new_highscore.emit(score)
		return true
	return false


func pause(value: bool = !_paused) -> void:
	_paused = value
	if not _is_fading:
		get_tree().paused = _paused
	_pause_display.visible = _paused
	_hud.visible = not _paused

	if _paused:
		_fade_over.process_mode = Node.PROCESS_MODE_DISABLED
		_intro_display.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		_fade_over.process_mode = Node.PROCESS_MODE_ALWAYS
		_intro_display.process_mode = Node.PROCESS_MODE_ALWAYS


func _on_input_manager_pause() -> void:
	pause()
