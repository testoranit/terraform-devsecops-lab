test:
	terraform fmt -recursive
	terraform validate
	tflint --init
	tflint

	@echo "Running Checkov (do not stop immediately)..."
	-mkdir -p evidence
	-checkov -d envs/dev > evidence/checkov.txt || true

	@echo "Generating Terraform plan..."
	terraform -chdir=envs/dev plan > ../evidence/plan.txt || true

	@echo "Evidence saved in evidence/"

