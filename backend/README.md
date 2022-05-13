# PetConnectBackend
 
ssh -i ".ssh/NicklasPlatz.pem" ubuntu@ec2-18-197-39-98.eu-central-1.compute.amazonaws.com

mvn clean install

scp -i .ssh/NicklasPlatz.pem F:/Git_Projects/hunde_zunder/backend/target/petConnect-0.15.jar ubuntu@ec2-18-197-39-98.eu-central-1.compute.amazonaws.com:~/petConnect/

sudo java -jar test.jar