import json
import oci
import pandas as pd


def load_input_object_locations(input_objects_json_file):
    '''
    Reads the Input Object locations from given json file
    '''
    object_locations = []

    with open(input_objects_json_file, "rb") as input_objects:
        data = json.load(input_objects)
        
    if 'input_objects' not in data:
        print('No input object locations.')
        return None
    
    else:
        for input_object in data["input_objects"]:
            if 'objects' not in input_object:
                continue
                
            for location in input_object["objects"]:
                object_location = oci.ai_vision.models.ObjectLocation()
                object_location.namespace_name = input_object["namespace"]
                object_location.bucket_name = input_object["bucket"]
                object_location.object_name = location
                object_locations.append(object_location)

        input_location = oci.ai_vision.models.ObjectListInlineInputLocation()
        input_location.object_locations = object_locations
        compartment_id = data["compartment_id"]

        return compartment_id, input_location


def load_output_object_location(output_object_json_file):
    '''
    Reads the Output Object location from given json file
    '''
    with open(output_object_json_file, "rb") as output_objects:
        data = json.load(output_objects)

    output_location = oci.ai_vision.models.OutputLocation()
    output_location.namespace_name = data["namespace"]
    output_location.bucket_name = data["bucket"]
    output_location.prefix = data["prefix"]
    return output_location

def display_classes(res_dict, class_column_name = 'Class'):
    '''
    Returns the DataFrame containing Class labels with their Confidence Levels
    '''
    res_dict = [{k: v for k, v in d.items() if k != 'bounding_polygon' and k != "boundingPolygon"} for d in res_dict]
    res_list = [list(res_dict[i].values()) for i in range(len(res_dict))]
    df = pd.DataFrame(res_list, columns = [class_column_name,'Confidence'])
    row_index = pd.Series(range(1, df.shape[0]+1))
    df = df.set_index([row_index])
    df = df.style.set_properties(**{'text-align': 'center'})
    df = df.set_table_styles([dict(selector = 'th', props=[('text-align', 'center')])])
    return df

def clean_output(res):
    '''
    Recursively removes all None values from the input json
    '''
    if isinstance(res, list):
        return [clean_output(x) for x in res if x is not None]
    elif isinstance(res, dict):
        return {
            key: clean_output(val)
            for key, val in res.items()
            if val is not None and val != []
        }
    else:
        return res