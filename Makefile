test:
	terraform fmt -recursive
	terraform validate
	tflint --init
	tflint
	checkov -d envs/dev
	terraform -chdir=envs/dev init
	terraform -chdir=envs/dev plan > evidence/plan.txt
	checkov -d envs/dev > evidence/checkov.txt

