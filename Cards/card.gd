extends Resource
class_name Card


@export var id: String
@export var name: String
@export var type: Constants.CardType
@export var texture: Texture2D
@export_multiline var details: String
@export var cost: int
@export var rarity: float

@export var scene: PackedScene
