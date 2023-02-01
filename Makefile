dev:
	terraform init && terraform workspace new dev || terraform workspace select dev && terraform apply -auto-approve 
qa:
	terraform init && terraform workspace new qa || terraform workspace select qa && terraform apply -auto-approve 
prod:
	terraform init && terraform workspace new prod || terraform workspace select prod && terraform apply -auto-approve 

destroy_dev:
	terraform init && terraform workspace select dev && terraform destroy -auto-approve 
destroy_qa:
	terraform init && terraform workspace select qa && terraform destroy -auto-approve 
destroy_prod:
	terraform init && terraform workspace select prod && terraform destroy -auto-approve 
