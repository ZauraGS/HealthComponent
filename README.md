# HealthComponent

A simple Node based approach to composition of health. When attached to a parent node you will grant it health related functions and let it micro manage the small details, such as clamping and detecting death. Combined with Signals you can easily get relevant information from the component without calling it from a process function.

In this project you will find a basic UI setup to control and exercise almost all functions you would typically use in your own.
![Godot_v4 3-stable_win64_4P8Jsw7Hlz](https://github.com/user-attachments/assets/d6392c21-bec6-4a18-8fc6-3b7c2b394509)

If you're new to Composition, I suggest watching these excellent videos on the subject.
- [Bitlytic](https://www.youtube.com/watch?v=74y6zWZfQKk)
- [Firebelly Games](https://www.youtube.com/watch?v=rCu8vQrdDDI)
- [Godotneers](https://youtu.be/W8gYHTjDCic)

### What it does:
- Manages Health
	- Clamping to 0, or Max Health
		- Toggle to allow exceeding maximum health
- Emits several signals
	- damaged(), When taking damage with an amount
	- healed() When taking healing with an amount
	- died(), When current health <= 0, with an Overkill amount
	- resurrected() When current health was 0, but is now >= 1
	- health_changed() When any change to current or max health happens
		- Used for Health Bars / Labels
- Healing the difference on max health change.
- Disallow Healing if Dead
- Disallow Resurrection if not Dead
- God Mode (Prevents all but forced damage)
- Provides methods to force damage and healing for scripted events.

### What it doesn't:
- Regeneration
- Mitigation (Armor, Resistance, Dodge, etc)
- Audio/Visual/Animations
- Serialization (See [##Node vs Resource])
- queue_free()

## Node vs Resource

In Godot, using a Node is "costly" (in relevant terms) compared to an Object/RefCounted. It also offers no serialization compared to a Resource.

The primary reason this component is a Node is for ease of use. It allows you to add it to script or node with a simple `@onready var health_component: HealthComponent = $HealthComponent` or exported property. It also allows easy connection of signals in editor.

Lastly, the health component can be used for a lot of different projects and entities. You don't necessarily need to serialize the health of a choppable tree, or a rodent enemy of Arena Survival game.

If you need to optimize further, you should be proficient enough to remove the @exports and change it to a RefCounted type, and add an _init() function.

## Credits

Pixel-Boy for his Godot Node Icons: https://pixel-boy.itch.io/icon-godot-node
