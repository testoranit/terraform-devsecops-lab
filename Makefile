test:
	@echo "Formatting Terraform..."
	terraform fmt -recursive

	@echo "Initializing Terraform..."
	terraform -chdir=envs/dev init -backend=false

	@echo "Validating Terraform..."
	terraform -chdir=envs/dev validate

	@echo "Running TFLint..."
	tflint --init
	tflint

	@echo "Creating evidence folder..."
	-mkdir -p evidence

	@echo "Running Checkov..."
	-checkov -d envs/dev > evidence/checkov.txt || true

	@echo "Generating Terraform Plan..."
	terraform -chdir=envs/dev plan -no-color > evidence/plan.txt || true

	@echo "Done. Evidence saved in evidence/"

