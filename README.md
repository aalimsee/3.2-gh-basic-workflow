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


# Verify Ruleset
## List existing rulesets:
gh ruleset list --repo OWNER/REPO

## Check details of a specific ruleset:
gh ruleset view --repo OWNER/REPO --name "Restrict Workflow Runs"

## Example:
% gh ruleset list --repo aalimsee/3.2-gh-basic-workflow

Showing 1 of 1 rulesets in aalimsee/3.2-gh-basic-workflow and its parents

ID       NAME                    SOURCE                                 STATUS  RULES
4579922  protect-default-branch  aalimsee/3.2-gh-basic-workflow (repo)  active  4

# Enforce branch protection and status checks
# To create the protect-default-branch ruleset using gh CLI, use the following command:
gh ruleset create \
  --repo aalimsee/3.2-gh-basic-workflow \
  --name "protect-default-branch" \
  --target "branch" \
  --enforcement "active" \
  --conditions 'ref_name={"include":["~DEFAULT_BRANCH"],"exclude":[]}' \
  --rules '[
    {"type": "deletion"},
    {"type": "non_fast_forward"},
    {"type": "pull_request", "parameters": {
      "allowed_merge_methods": ["merge", "squash", "rebase"],
      "automatic_copilot_code_review_enabled": false,
      "dismiss_stale_reviews_on_push": false,
      "require_code_owner_review": false,
      "require_last_push_approval": false,
      "required_approving_review_count": 0,
      "required_review_thread_resolution": false
    }},
    {"type": "required_status_checks", "parameters": {
      "do_not_enforce_on_create": false,
      "required_status_checks": [{"context": "CI", "integration_id": 15368}],
      "strict_required_status_checks_policy": false
    }}
  ]' \
  --bypass-actors "never" \
  --description "Protects the default branch by enforcing merge rules and CI checks."
