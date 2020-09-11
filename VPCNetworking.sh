####################
# SHELL SCRIPT OBJECTIVES
#  - Create VPN gateways in each network
#  - Create VPN tunnels between the gateways
####################


#Create the vpn-1 gateway and tunnel1to2

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" target-vpn-gateways create "vpn-1" --region "us-central1" --network "vpn-network-1"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" forwarding-rules create "vpn-1-rule-esp" --region "us-central1" --address "34.123.15.238" --ip-protocol "ESP" --target-vpn-gateway "vpn-1"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" forwarding-rules create "vpn-1-rule-udp500" --region "us-central1" --address "34.123.15.238" --ip-protocol "UDP" --ports "500" --target-vpn-gateway "vpn-1"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" forwarding-rules create "vpn-1-rule-udp4500" --region "us-central1" --address "34.123.15.238" --ip-protocol "UDP" --ports "4500" --target-vpn-gateway "vpn-1"


gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" vpn-tunnels create "tunnel1to2" --region "us-central1" --peer-address "104.199.27.5" --shared-secret "gcprocks" --ike-version "1" --local-traffic-selector "0.0.0.0/0" --target-vpn-gateway "vpn-1"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" routes create "tunnel1to2-route-1" --network "vpn-network-1" --next-hop-vpn-tunnel "tunnel1to2" --next-hop-vpn-tunnel-region "us-central1" --destination-range "10.1.3.0/24"




#Create the vpn-2 gateway and tunnel2to1

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" target-vpn-gateways create "vpn-2" --region "europe-west1" --network "vpn-network-2"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" forwarding-rules create "vpn-2-rule-esp" --region "europe-west1" --address "104.199.27.5"  --ip-protocol "ESP" --target-vpn-gateway "vpn-2"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" forwarding-rules create "vpn-2-rule-udp500" --region "europe-west1" --address "104.199.27.5"  --ip-protocol "UDP" --ports "500" --target-vpn-gateway "vpn-2"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" forwarding-rules create "vpn-2-rule-udp4500" --region "europe-west1" --address "104.199.27.5"  --ip-protocol "UDP" --ports "4500" --target-vpn-gateway "vpn-2"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" vpn-tunnels create "tunnel2to1" --region "europe-west1" --peer-address "34.123.15.238" --shared-secret "gcprocks" --ike-version "1" --local-traffic-selector "0.0.0.0/0" --target-vpn-gateway "vpn-2"

gcloud compute --project "qwiklabs-gcp-01-82b266ec5dca" routes create "tunnel2to1-route-1" --network "vpn-network-2" --next-hop-vpn-tunnel "tunnel2to1" --next-hop-vpn-tunnel-region "europe-west1" --destination-range "10.1.3.0/24"


#TESTING CONECTIVITY

#VM instance 1
ping -c 3 104.199.27.5

#on VM instance 2
ping -c 3 34.123.15.238
