
import os

def convert_yaml_to_json(dataType, imagePath):

    print("Converting YAML file " + imagePath + " to JSON.")
    print("Data type is: " + dataType)

    tmp1 = os.path.splitext(imagePath)[0]
    
    image_path_stem = os.path.splitext(tmp1)[0]

    # Convert YAML file to JSON
    import yaml
    import json
    with open("data/" + str(image_path_stem) + ".yaml", 'r') as yaml_in, open("data/" + str(image_path_stem) + ".json", "w") as json_out:
        yaml_object = yaml.safe_load(yaml_in) # yaml_object will be a list or a dict
        json.dump(yaml_object, json_out)
    
    print("Conversion complete!")
