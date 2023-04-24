import json
import oci
import time
from vision_service_python_client.ai_service_vision_client import AIServiceVisionClient
from vision_service_python_client.ai_service_vision_client import AIServiceVisionClient
from vision_service_python_client.models.inline_image_details import InlineImageDetails
from vision_service_python_client.models.analyze_image_details import AnalyzeImageDetails
from vision_service_python_client.models.object_storage_image_details import ObjectStorageImageDetails
from vision_service_python_client.models.image_classification_feature import ImageClassificationFeature
from vision_service_python_client.models.image_object_detection_feature import ImageObjectDetectionFeature
from vision_service_python_client.models.image_text_detection_feature import ImageTextDetectionFeature
from vision_service_python_client.ai_service_vision_client import AIServiceVisionClient
from vision_service_python_client.models.create_image_job_details import CreateImageJobDetails
from vision_service_python_client.models.image_classification_feature import ImageClassificationFeature
from vision_service_python_client.models.image_object_detection_feature import ImageObjectDetectionFeature
from vision_service_python_client.models.image_text_detection_feature import ImageTextDetectionFeature
from vision_service_python_client.models.input_location import InputLocation
from vision_service_python_client.models.object_list_inline_input_location import ObjectListInlineInputLocation
from vision_service_python_client.models.object_location import ObjectLocation
from vision_service_python_client.models.object_storage_document_details import ObjectStorageDocumentDetails
from vision_service_python_client.models.output_location import OutputLocation
from vision_service_python_client.models.object_list_inline_input_location import ObjectListInlineInputLocation

config = oci.config.from_file('~/.oci/config')

endpoint = "https://vision.aiservice.us-ashburn-1.oci.oraclecloud.com"
object_detection_modelid = "<your_vision_model_ocid>"
namespace = "your_tenancy_namespace"
input_bucket = "input"
output_bucket = "output"
compartment = "<your_compartment_ocid>"
start_image = "test.jpg"
MAX_RESULTS = 50

# Initialize client service_endpoint is optional if it's specified in config
# ai_service_vision_client = AIServiceVisionClient(config=config, service_endpoint=endpoint)
ai_service_vision_client = AIServiceVisionClient(config=config)
object_storage_client = oci.object_storage.ObjectStorageClient(config)

# Set up request body with multiple features
#image_classification_feature = ImageClassificationFeature()
#image_classification_feature.max_results = MAX_RESULTS
image_object_detection_feature = ImageObjectDetectionFeature()
image_object_detection_feature.max_results = MAX_RESULTS
image_object_detection_feature.model_id = object_detection_modelid
#image_text_detection_feature = ImageTextDetectionFeature()
features = [image_object_detection_feature]

#Set up list of images
list_objects_response = object_storage_client.list_objects(
    namespace_name=namespace,
    bucket_name=input_bucket)

testdata=list_objects_response.data.objects
# Setup input locations
j = 0 #set index
object_locations= [] #initialize list
object_locations.append(ObjectLocation())
object_locations[j].namespace_name = namespace
object_locations[j].bucket_name = input_bucket
object_locations[j].object_name = start_image
#object_locations = [object_location]
input_location = ObjectListInlineInputLocation()
input_location.object_locations = object_locations

#Setup output location
output_location = OutputLocation()
output_location.namespace_name = namespace
output_location.bucket_name = output_bucket
output_location.prefix = "result"

# Details setup
create_image_job_details = CreateImageJobDetails()
create_image_job_details.features = features
create_image_job_details.compartment_id = "ocid1.compartment.oc1..aaaaaaaaj7pgqygsuco2f54crotdyheuqsv6gvpphpfrdvge5gnraeoyd2ka"
create_image_job_details.output_location = output_location
create_image_job_details.input_location = input_location

res = ai_service_vision_client.create_image_job(create_image_job_details=create_image_job_details)
print("**************************Analyze Image Batch Job**************************")
print(res.data)

job_id = res.data.id
print(job_id)
seconds = 0
res = ai_service_vision_client.get_image_job(image_job_id=job_id)
while res.data.lifecycle_state == "IN_PROGRESS" or res.data.lifecycle_state == "ACCEPTED":
    print("Job " + job_id + " is IN_PROGRESS for " + str(seconds) + " seconds")
    time.sleep(5)
    seconds += 5
    res = ai_service_vision_client.get_image_job(image_job_id=job_id)

print("**************************Get Image Job Result**************************")
print(res.data)

start_json = "result/" + job_id + "/" + namespace + "_" + input_bucket + "_" + start_image + ".json"

list_objects_response = object_storage_client.list_objects(
    namespace_name=namespace,
    bucket_name=output_bucket,
    start = start_json)
 
#Test type of object
list_results_names = (list_objects_response.data.objects)

pipes_count_i = 0 
      
object_text = object_storage_client.get_object(
    namespace_name=namespace,
    bucket_name=output_bucket,
    object_name = start_json)

i = 0
dict_value = json.loads(object_text.data.content)
print(list_objects_response.data.objects[i].name)
for pipes in dict_value['imageObjects']:
    if pipes['confidence'] >= 0.50:
        # adjust confidence value
        if pipes['name'] == 'pipes':
            pipes_count_i += 1
                    
print(pipes_count_i)
