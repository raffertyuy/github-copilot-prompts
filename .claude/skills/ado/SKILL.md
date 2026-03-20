---
name: ado
description: Use the Azure DevOps MCP server for project management
---
Use the "ado" MCP server.
- When querying for a specific project, first check if the project exists.
- If the project does not exist, or if there are any sign that indicates that the user might not have the right permissions, remind the user to first log-in by running `az login` in the CLI (requires Azure CLI installed).
