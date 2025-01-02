class_name Mao extends Node2D

# Constants for layout
const MAX_CARDS := 6
const CARD_SPACING := 110  # Horizontal space between cards
const HAND_HEIGHT := 700   # Y position where cards rest
const ANIMATION_DURATION := 0.2  # Seconds for card movement animations

@export var cartas: Array[Carta]
var card_positions: Array[Vector2]
var target_position: Vector2  # For card being dragged

func _ready() -> void:
    # Initialize empty hand
    cartas = []
    calculate_card_positions()
    
    # Connect to signals when cards are added as children
    child_entered_tree.connect(_on_child_entered)
    child_exiting_tree.connect(_on_child_exiting)

func calculate_card_positions() -> void:
    card_positions.clear()
    
    if cartas.is_empty():
        return
        
    # Calculate total width of all cards with spacing
    var total_width := (cartas.size() - 1) * CARD_SPACING
    # Calculate starting X position to center the hand
    var start_x := -total_width / 2
    
    # Calculate position for each card
    for i in range(cartas.size()):
        var pos := Vector2(start_x + (i * CARD_SPACING), HAND_HEIGHT)
        card_positions.append(pos)

func add_carta(carta: Carta) -> void:
    if cartas.size() >= MAX_CARDS:
        return
        
    # Add card to beginning of array
    cartas.push_front(carta)
    
    # Setup card
    add_child(carta)
    carta.position = Vector2(0, -200)  # Start above hand
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
    # Store original position for potential reordering
    target_position = carta.position
    # Bring dragged card to front
    move_child(carta, -1)

func _on_card_drag_ended(carta: Carta) -> void:
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

# Optional: Add method to check if a position is within hand area
func is_position_in_hand_area(pos: Vector2) -> bool:
    var hand_rect := Rect2(
        Vector2(-get_viewport_rect().size.x/2, HAND_HEIGHT - 100),
        Vector2(get_viewport_rect().size.x, 200)
    )
    return hand_rect.has_point(pos)