# Author: Aman Swarnkar

'''Example of using gcloud & Python to get instance labels and metadata'''

import subprocess
import json
import shlex
import sys

def get_instance_metadata(instance_name, key=""):
    '''
    This function takes an instance name of a google compute engine and returns the metadata of that instance.
    It return all of the metadata keys and value if no key has been passed.
    '''
    get_zone_command = "gcloud compute instances list --filter='name:("+ instance_name + ")' --format 'get(zone)'"
    zone= subprocess.check_output(shlex.split(get_zone_command))
    instance_metadata_command = "gcloud compute instances describe " + instance_name + " --flatten='metadata["+ key + "]' --zone=" + zone +" --format json"
    instance_metadata= subprocess.check_output(shlex.split(instance_metadata_command))
    return instance_metadata
    
if __name__ =='__main__':
    instance_name = sys.argv[1]
    key=sys.argv[2] if len(sys.argv) >2 else ""
    print(get_instance_metadata(instance_name,key))
