# 3.2-gh-basic-workflow

# Add the Secret
Use the following command, replacing the placeholders with your actual values:
    ```gh secret set <secret-name> --body <secret-value> --repo <org/repo-name>```

<secret-name>: The name you want to give the secret (e.g., API_KEY). 
<secret-value>: The actual value of the secret (e.g., a token, password). 
<org/repo-name>: The full name of the repository (e.g., my-org/my-repo). 

# Example
    ```gh secret set AWS_ACCESS_KEY_ID --body AKIATXF4JQPH2AEBPPOO --repo aalimsee/3.2-gh-basic-workflow```
    ```gh secret set AWS_SECRET_ACCESS_KEY --body <secret-value> --repo aalimsee/3.2-gh-basic-workflow```


# How to fix the issues above:
TFlint - Look for the rule that is failing here(You may have to refer to terraform docs as well): [tflint-ruleset-terraform/docs/rules at main · terraform-linters/tflint-ruleset-terraform](https://github.com/terraform-linters/tflint-ruleset-terraform/tree/main/docs/rules)
Suppressing the checkov checks: [Suppressing and Skipping Policies - checkov](https://www.checkov.io/2.Basics/Suppressing%20and%20Skipping%20Policies.html)

# Pull Request Errors and Fixes

Run tflint -f compact
  tflint -f compact
  shell: /usr/bin/bash -e {0}
  env:
    AWS_DEFAULT_REGION: us-east-1
    AWS_REGION: us-east-1
    AWS_ACCESS_KEY_ID: ***
    AWS_SECRET_ACCESS_KEY: ***
    TERRAFORM_CLI_PATH: /home/runner/work/_temp/7ff58435-cdd2-4d0f-a533-089fcfbc1277
3 issue(s) found:

Warning: main.tf:19:28: Warning - Interpolation-only expressions are deprecated in Terraform v0.12.14 (terraform_deprecated_interpolation) 
# https://github.com/terraform-linters/tflint-ruleset-terraform/blob/main/docs/rules/terraform_deprecated_interpolation.md 

Warning: main.tf:23:1: Warning - Missing version constraint for provider "aws" in `required_providers` (terraform_required_providers)
# https://github.com/terraform-linters/tflint-ruleset-terraform/blob/main/docs/rules/terraform_required_providers.md 

Warning: main.tf:8:1: Warning - terraform "required_version" attribute is required (terraform_required_version)
# https://github.com/terraform-linters/tflint-ruleset-terraform/blob/main/docs/rules/terraform_required_version.md 