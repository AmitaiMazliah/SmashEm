#extends Reference

class_name Promise

signal completed

enum MODE {ANY, ALL}
var mode: int = MODE.ANY

var _signals: Dictionary = {}
var _signals_count : int
var _completed_signals_count : int
var _completed: bool = false

func _init(signals: Array, mode: int) -> void:
	_signals_count = signals.size()
	for s in signals:
		s.connect(_on_signal)

func _on_signal():
	#_signals[s].has_emitted = true
	#_signals[s].data = [arg1]
	_completed_signals_count += 1
	_check_completion()

func _check_completion():
	if _completed:
		return
	if mode == MODE.ANY:
		_check_any_completion()
	elif mode == MODE.ALL:
		_check_all_completion()

func _check_any_completion() -> void:
	if _completed_signals_count > 0:
		completed.emit()

func _check_all_completion() -> void:
	if _completed_signals_count == _signals_count:
		completed.emit()
