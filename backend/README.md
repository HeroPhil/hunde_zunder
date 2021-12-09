# PetConnectBackend
 
ssh -i ".ssh/NicklasPlatz.pem" ubuntu@ec2-18-193-47-171.eu-central-1.compute.amazonaws.com

mvn clean install

scp -i .ssh/NicklasPlatz.pem F:/Git_Projects/PetConnectBackend/target/test.jar ubuntu@ec2-18-193-47-171.eu-central-1.compute.amazonaws.com:~/petConnect/

sudo java -jar test.jar