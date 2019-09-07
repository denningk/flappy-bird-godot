# script: utils

extends Node

func get_main_node() -> Node:
	var root_node : Node = get_tree().get_root()
	return root_node.get_child(root_node.get_child_count() - 1)

func get_digits(number: int) -> Array:
	var str_number : String = str(number)
	var digits : Array = []
	
	for i in range(str_number.length()):
		digits.append(str_number[i].to_int())
		
	return digits