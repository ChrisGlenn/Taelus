extends Node
# EQUIPMENT
# a database or dictionary of the equippable weapons, armor, shields, ect.

# {finder: reference id,name: name displayed,influence: how the clothing/armor effects public opinion,class: class of armor,type: type of armor/clothing,mod: mod effector,durability: durability of item,inv_frame: inventory frame,equip_frame: avatar equip frame}
var armor = [
    {"finder": "NKD","name": "Naked","influence": -10,"class": "Unequipped","type": "Clothing","armor_class_mod": 0,"durabiliity": -4,"inv_frame": 0,"equip_frame": 0},
    {"finder": "RAG","name": "Cloth Rags","influence": -5,"class": "Light Armor","type": "Clothing","armor_class_mod": 3,"durability": -4,"inv_frame": 257,"equip_frame": 1}
]

var weapon = {}
var shield = {}
var helmet = {}
# rings provide protection/buffs
var ring = {}
# amulets are the magical items needed to cast spells
var amulet = {}