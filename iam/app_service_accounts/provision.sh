input=$1

if [[ "$input" == "i" ]]; then
    terraform init --upgrade -reconfigure --backend-config=backend/backend.conf
elif [[ "$input" == "p" ]]; then
    terraform plan --var-file=env/dev-region-1.tfvars
elif [[ "$input" == "a" ]]; then 
    terraform apply --var-file=env/dev-region-1.tfvars -auto-approve
elif [[ "$input" == "d" ]]; then
    terraform destroy --var-file=env/dev-region-1.tfvars -auto-approve
fi