## Coding Standards
- if responding with code that include a class, function or method definition, add doc-string comments.
- review for possible exceptions and add exception handling.
- No abbreviations. Names should not be abbreviated.
- Constants follow ALL_CAPS snake case (otherwise known as Screaming Snake Case).
- Avoid using magic strings. Either parameterize or create constants.
- If CLI commands or file paths are generated, ensure compatibility with Windows.

### Code Nesting
- Avoid deeply nested code. Break down logic into smaller functions.
- Use 4 spaces for indentation
- Opening curly braces should be on the same line as the statement.

### Error Handling
- Always catch a specific error instead of a generic one.
- Log the error message and stack trace.