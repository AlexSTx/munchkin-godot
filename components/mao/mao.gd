class_name Mao extends Node2D

# Constants for layout
const MAX_CARDS := 6
const CARD_SPACING := 0  # Horizontal space between cards
const ANIMATION_DURATION := 0.2  # Seconds for card movement animations

@export var cartas: Array[Carta]
var card_positions: Array[Vector2]
var target_position: Vector2

var is_holding_card := false
var card_held : Carta

# Hand area properties
var hand_area_position: Vector2
var hand_area_width: float
var hand_area_height: float


func _ready() -> void:
    cartas = []
    calculate_card_positions()
    
    child_entered_tree.connect(_on_child_entered)
    child_exiting_tree.connect(_on_child_exiting)


func set_hand_area(pos: Vector2, width: float, height: float) -> void:
    hand_area_position = pos
    hand_area_width = width
    hand_area_height = height
    calculate_card_positions()


func calculate_card_positions() -> void:
    card_positions.clear()
    
    if cartas.is_empty():
        return
        
    # Calculate total width of all cards with spacing
    var total_width : int = Carta.CARD_WIDTH * (cartas.size()) + (cartas.size() - 1) * CARD_SPACING
    
    # Calculate starting X position to center within hand area
    var start_x := hand_area_position.x + hand_area_width - total_width
    var cards_y : float = hand_area_position.y + (hand_area_height - Carta.CARD_HEIGHT) / 2
    
    # Calculate position for each card
    for i in range(cartas.size()):
        var pos := Vector2(
            start_x + Carta.CARD_WIDTH * i + (i * CARD_SPACING),
            cards_y
        )
        card_positions.append(pos)


func add_carta(carta: Carta) -> void:
    if cartas.size() >= MAX_CARDS:
        return
        
    # Add card to beginning of array
    cartas.push_front(carta)
    
    # Setup card
    add_child(carta)
    carta.drag_started.connect(_on_card_drag_started.bind(carta))
    carta.drag_ended.connect(_on_card_drag_ended.bind(carta))
    
    # Recalculate positions and animate all cards
    calculate_card_positions()
    animate_cards()


func _on_child_entered(node: Node) -> void:
    if node is Carta and not cartas.has(node):
        add_carta(node as Carta)


func _on_child_exiting(node: Node) -> void:
    if node is Carta:
        var carta := node as Carta
        var idx := cartas.find(carta)
        if idx != -1:
            cartas.remove_at(idx)
            calculate_card_positions()
            animate_cards()


func _on_card_drag_started(carta: Carta) -> void:
    is_holding_card = true

    for c in cartas:
        c.disable_hover_animation()
        if c != carta:
            c.disable_drag()

    # Store original position for potential reordering
    target_position = carta.position
    # Bring dragged card to front
    move_child(carta, -1)


func _on_card_drag_ended(carta: Carta) -> void:
    is_holding_card = false

    for c in cartas:
        c.enable_hover_animation()
        c.enable_drag()

    if not is_position_in_hand_area(carta.position):
        animate_cards()
        return 

    var carta_idx := cartas.find(carta)
    if carta_idx == -1:
        return
        
    # Find nearest position in hand
    var min_dist := INF
    var target_idx := carta_idx
    
    for i in range(card_positions.size()):
        var dist := carta.position.distance_to(card_positions[i])
        if dist < min_dist:
            min_dist = dist
            target_idx = i
    
    # Reorder if position changed
    if target_idx != carta_idx:
        cartas.remove_at(carta_idx)
        cartas.insert(target_idx, carta)
        calculate_card_positions()
    
    animate_cards()


func animate_cards() -> void:
    for i in range(cartas.size()):
        var carta := cartas[i]
        var tween := create_tween()
        tween.tween_property(carta, "position", card_positions[i], ANIMATION_DURATION)


func is_position_in_hand_area(pos: Vector2) -> bool:
    var hand_rect := Rect2(
        hand_area_position,
        Vector2(hand_area_width, hand_area_height)
    )
    return hand_rect.has_point(pos)