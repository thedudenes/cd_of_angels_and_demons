@tool
extends AnimationPlayer
#DEFINE THE PATHS
#This is the part we want to REMOVE
@export var old_prefix: String = "Armature/Skeleton3D"
#This is what we put in its place (Empty string means we just delete the old prefix)
#If you REALLY need "rig/", change the "" to "rig/" below.
@export var new_prefix: String = "%GeneralSkeleton"
  
func _ready():
	var anim_list = get_animation_list()
	var count = 0

	# 3. LOOP AND REPLACE
	for anim_name in anim_list:
		var anim = get_animation(anim_name)
		
		for i in range(anim.get_track_count()):
			var current_path = str(anim.track_get_path(i))
			#print(current_path)
			if current_path.begins_with(old_prefix):
				#print("delete this track")
				var fixed_path = current_path.replace(old_prefix, new_prefix)
				#print(fixed_path)
				anim.track_set_path(i, NodePath(fixed_path))
				#print(str(anim.track_get_path(i)))
				count += 1
				
	
	print("------------------------------------------------")
	print("FIX REPORT: Updated ", count, " tracks.")
	print("Please SAVE the scene (Ctrl+S) and RELOAD the project.")
	print("------------------------------------------------")
