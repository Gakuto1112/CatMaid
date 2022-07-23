import os
import json
import re

MODEL_LIST = os.listdir("./models")

for model in MODEL_LIST:
	with open(f"./models/{model}", mode="r", encoding="utf-8") as f:
		json_data = json.load(f)
	for elementIndex, element in enumerate(json_data["elements"]):
		for face in ("north", "east", "south", "west", "up", "down"):
			if not element["faces"][face] is None:
				for uvIndex, uv in enumerate(element["faces"][face]["uv"]):
					errorValue = re.search("(\\d)\\1{2,}", str(uv))
					if errorValue:
						roundValue = round(uv, errorValue.start())
						roundValueMatch = re.search("\\.0+$", str(roundValue))
						if roundValueMatch:
							roundValue = int(str(roundValue)[:roundValueMatch.start()])
						json_data["elements"][elementIndex]["faces"][face]["uv"][uvIndex] = roundValue
	with open(f"./models/{model}", mode="w", encoding="utf-8") as f:
		json.dump(json_data, f, indent=4)