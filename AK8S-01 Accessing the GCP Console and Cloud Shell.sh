
#Creating virtual machines

gcloud beta compute --project=qwiklabs-gcp-00-eb1270ba9655 instances create first-vm --zone=us-central1-c --machine-type=f1-micro --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=774581789686-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server --image=debian-10-buster-v20200910 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=first-vm --no-shielded-secure-boot --no-shielded-vtpm --no-shielded-integrity-monitoring --reservation-affinity=any

gcloud compute --project=qwiklabs-gcp-00-eb1270ba9655 firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server


##############################
#Task 2 - Explore Cloud Shell
##############################

MY_BUCKET_NAME_1=qwiklabs-gcp-00-eb1270ba9655
MY_BUCKET_NAME_2=second-qwiklabs-gcp-00-eb1270ba9655
MY_REGION=us-central1
USERNAME=student-00-6c0e780e5fd8@qwiklabs.net
gsutil mb gs://$MY_BUCKET_NAME_2


# Use the gcloud command line to create a second virtual machine

gcloud compute zones list | grep $MY_REGION
gcloud compute zones list | grep $MY_REGION

MY_ZONE=us-central1-a
gcloud config set compute/zone $MY_ZONE

MY_VMNAME=second-vm
gcloud compute instances create $MY_VMNAME \
--machine-type "n1-standard-1" \
--image-project "debian-cloud" \
--image-family "debian-9" \
--subnet "default"

gcloud compute instances list


# Use the gcloud command line to create a second service account

gcloud iam service-accounts create test-service-account2 --display-name "test-service-account2"

gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account2@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/viewer


##############################################
#Task 3. Work with Cloud Storage in Cloud Shell
##############################################


#Download a file to Cloud Shell and copy it to Cloud Storage

gsutil cp gs://cloud-training/ak8s/cat.jpg cat.jpg

gsutil cp cat.jpg gs://$MY_BUCKET_NAME_1

gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg gs://$MY_BUCKET_NAME_2/cat.jpg


# Set the access control list for a Cloud Storage object

gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg  > acl.txt
cat acl.txt

gsutil acl set private gs://$MY_BUCKET_NAME_1/cat.jpg

gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg  > acl-2.txt
cat acl-2.txt

gcloud config list

gcloud auth activate-service-account --key-file credentials.json

gcloud config list

gcloud auth list

gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg ./cat-copy.jpg
gsutil cp gs://$MY_BUCKET_NAME_2/cat.jpg ./cat-copy.jpg

gcloud config set account USERNAME
gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg ./copy2-of-cat.jpg
gsutil iam ch allUsers:objectViewer gs://$MY_BUCKET_NAME_1




##############################################
#Task 4. Explore the Cloud Shell code editor
##############################################

git clone https://github.com/googlecodelabs/orchestrate-with-kubernetes.git

mkdir test

cd orchestrate-with-kubernetes

echo "echo Finished cleanup!" >>cleanup.sh

cat cleanup.sh

cd 





