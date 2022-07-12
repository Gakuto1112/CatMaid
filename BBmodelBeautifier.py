import json

with open("player_model.bbmodel", mode="r") as f:
	json_data = json.load(f)

with open("player_model.bbmodel", mode="w") as f:
	json.dump(json_data, f, indent=4)