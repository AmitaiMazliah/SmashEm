extends Resource

class_name AudioCue

@export var looping : bool
@export var sequenceMode : SequenceMode = SequenceMode.RandomNoImmediateRepeat
@export var audioClips : Array[AudioStream]

var _nextClipToPlay : int = -1;
var _lastClipPlayed : int = -1;

func get_next_clip() -> AudioStream:
	if audioClips.size() == 1:
		return audioClips[0]

	randomize()
	if (_nextClipToPlay == -1):
		# Index needs to be initialised: 0 if Sequential, random if otherwise
		if sequenceMode == SequenceMode.Sequential:
			_nextClipToPlay = 0
		else:
			_nextClipToPlay = randi() % audioClips.size()
	else:
		# Select next clip index based on the appropriate SequenceMode
		match sequenceMode:
			SequenceMode.Random:
				_nextClipToPlay = randi() % audioClips.size()
			SequenceMode.RandomNoImmediateRepeat:
				while _nextClipToPlay == _lastClipPlayed:
					_nextClipToPlay = randi() % audioClips.size()
			SequenceMode.Sequential:
				_nextClipToPlay = posmod(++_nextClipToPlay, audioClips.size())

	_lastClipPlayed = _nextClipToPlay;

	return audioClips[_nextClipToPlay];

enum SequenceMode
{
	Random,
	RandomNoImmediateRepeat,
	Sequential
}
