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

