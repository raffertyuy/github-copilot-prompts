---
applyTo: '**/*.sql'
---
# T-SQL Coding Best Practices

## SQL-Specific Guidelines
- Use uppercase for T-SQL keywords and lowercase for identifiers.
- Avoid using reserved words as object names.
- Always terminate statements with a semicolon.
- Use schema names when referencing objects (e.g., dbo.TableName).
- Avoid using SELECT *; explicitly specify required columns.

## Formatting
- Place each statement on its own line.
- Align related clauses (e.g., SELECT, FROM, WHERE, JOIN) vertically.
- Use consistent casing for identifiers and keywords.

## Error Handling
- Use TRY...CATCH blocks for error handling in stored procedures and scripts.
- Log error messages and error numbers for troubleshooting.

## Performance
- Use appropriate indexes to optimize query performance.
- Avoid using cursors when set-based operations are possible.
- Use EXISTS instead of COUNT(*) for existence checks.
- Avoid scalar functions in SELECT statements; prefer inline table-valued functions.
- Use table variables or temporary tables judiciously.

## Security
- Grant the least privilege necessary to users and roles.
- Avoid using the sa account for application connections.

## Maintainability
- Use consistent naming conventions (e.g., PascalCase or snake_case).
- Document stored procedures, functions, and complex queries with comments.
- Break down large scripts into smaller, reusable modules.

## Version Control
- Store all database scripts in version control.
- Use clear and descriptive commit messages for database changes.