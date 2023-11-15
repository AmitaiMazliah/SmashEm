class_name AudioCueKey

var value
var audio_cue: AudioCue

func _init(audio_cue: AudioCue):
	self.audio_cue = audio_cue
	self.value = hash(audio_cue)
	print(hash(audio_cue))
	print(hash("gregre"))
	var f = 5

static var invalid: AudioCueKey = AudioCueKey.new(null)
