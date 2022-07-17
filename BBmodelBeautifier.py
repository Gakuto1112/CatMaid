import os
import json

MODEL_LIST = os.listdir("./models")

for model in MODEL_LIST:
	with open(f"./models/{model}", mode="r", encoding="utf-8") as f:
		json_data = json.load(f)
	with open(f"./models/{model}", mode="w", encoding="utf-8") as f:
		json.dump(json_data, f, indent=4)