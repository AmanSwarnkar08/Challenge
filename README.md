## README

# Challenge 1
* A 3-tier environment setup using terraform automation. In this case we are using a gcs bucket as a remote backend to store the state file to track all the google cloud resources.
* We are creating VPC network, required subnetworks, essential firewall rules, a gke cluster to deploy any microservice application, a bastion host server with required tools and library and a postgres cloud sql database.
* Using these resources we can create a 3-tier web application Network Layer (Cloud Load Balancing), Application Layer(Main Application with user interface deployed in a GKE cluster) and Data Layer (Postgres Cloud SQL).

# Challenge 2
* Usng gcloud and python programming language retrieving metadata of a gce instance.
* In order to run this file use command line arguments. First argument for instance name and second argument for key whose value is to be retrieved, If no key is passed it will return all the metadata of a gce instance in json format.

# Challenge 3
* A python program to fetch the values from a nested dictionary object.
