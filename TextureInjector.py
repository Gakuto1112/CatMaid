import os
import json
import base64

MODEL_LIST = os.listdir("./models")

def inject(root: str) -> None:
	for model in MODEL_LIST:
		with open(f"{root}/models/{model}", mode="r", encoding="utf-8") as model_file:
			json_data = json.load(model_file)
		for index, texture in enumerate(json_data["textures"]):
			textureName = texture["relative_path"].split("/")[-1:][0]
			if os.path.exists(f"{root}/textures/{textureName}"):
				with open(f"{root}/textures/{textureName}", mode="rb") as texture_file:
					data = base64.b64encode(texture_file.read())
					json_data["textures"][index]["source"] = f"data:image/png;base64,{data.decode('utf-8')}"

		with open(f"{root}/models/{model}", mode="w", encoding="utf-8") as model_file:
			json.dump(json_data, model_file, indent=4)

if __name__ == "__main__":
	inject(".")