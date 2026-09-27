extends Node2D
class_name SfxBuilder

@export var values: SFXBuilderResource

var particles: Array[CPUParticles2D]
var sound_effects: Array[AudioStreamPlayer2D]

var target: Node2D
var _real_target: Node2D

func set_target(t: Node2D) -> SfxBuilder:
    self.target = t
    _real_target = t.get_parent()
    _real_target.add_child(self)
    global_position = target.global_position
    return self

func set_values(v: SFXBuilderResource) -> SfxBuilder:
    values = v
    return self

func run():
    for particle in values.particles:
        var particle_instance = particle.instantiate() as CPUParticles2D
        assert(particle_instance != null, "No es una instancia de CPUParticles2D")

        particle_instance.emitting = false

        add_child(particle_instance)
        particles.append(particle_instance)
    
    for sound in values.sound_effects:
        var stream_player = AudioStreamPlayer2D.new()
        stream_player.bus = "SFX"
        stream_player.stream = sound
        add_child(stream_player)
        sound_effects.append(stream_player)

    for particle in particles:
        particle.emitting = true       
    
    for sound_player in sound_effects:
        sound_player.play()

    await get_tree().create_timer(5).timeout
    queue_free()