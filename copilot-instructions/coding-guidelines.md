# Coding Guidelines

## Clean and Readable Code
- Naming should be readable and should not be abbreviated.
- For class/method/function definitions, Docstring-style comments are required.
- For in-line code comments, suggest to clean/refactor the code to make it more readable without the need for comments.

## Magic Strings
- Avoid using magic strings. Either parameterize or create constants.

## Nesting
- Avoid deeply nested code. Break down logic into smaller functions.
- Use 4 spaces for indentation
- Opening curly braces should be on the same line as the statement.

## Error Handling
- Always catch a specific error instead of a generic one.
- Log the error message and stack trace.