from urllib.parse import urlparse
import pandas as pd

def is_url(url):
    '''
    Returns True is the input is a Valid URL, otherwise False
    '''
    try:
        result = urlparse(url)
        return all([result.scheme, result.netloc])
    except ValueError:
        return False
    
def display_classes(res_dict, class_column_name = 'Class'):
    '''
    Returns the DataFrame containing Class labels with their Confidence Levels
    '''
    res_dict = [{k: v for k, v in d.items() if k != 'bounding_polygon' and k != 'word_indexes'} for d in res_dict]
    res_list = [list(reversed(list(res_dict[i].values()))) for i in range(len(res_dict))]
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