build:
	CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags "-s -w" -o ./terraform/bin/app ./src/main.go

terraform-init:
	terraform -chdir=./terraform init

terraform-plan:
	terraform -chdir=./terraform plan

terraform-apply:
	terraform -chdir=./terraform apply -auto-approve

terraform-destroy:
	terraform -chdir=./terraform destroy

build-and-deploy:
	$(MAKE) build
	$(MAKE) terraform-apply