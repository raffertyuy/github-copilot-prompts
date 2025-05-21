## Coding Standards

### General Guidelines

- Use descriptive variable, function, and class names. Avoid abbreviations.
- Follow consistent casing: camelCase or snake_case for variables/functions, PascalCase for classes, ALL_CAPS for constants.
- Avoid magic numbers and strings; define them as constants.
- Write small, single-purpose functions and classes.
- Place imports at the top of the file, grouped logically.

### Formatting

- Use 4 spaces per indentation level.
- Limit lines to a reasonable length (80-120 characters).
- Place opening curly braces on the same line as the statement.
- Use consistent whitespace and formatting.
- Avoid deeply nested code. Break down logic into smaller functions.

### Error Handling

- Always catch specific exceptions, not generic ones.
- Log error messages and stack traces for debugging.
- Clean up resources properly in all cases (success, error, early return).

### Documentation

- Add comments/docstrings to all public classes, functions, and methods.
- Document parameters, return values, and exceptions.
- Use comments to explain complex logic or business rules.

### Security

- Never hardcode sensitive information (passwords, API keys).
- Validate and sanitize all external input.
- Use parameterized queries for database access.

### Windows Compatibility

- Use cross-platform path handling (e.g., os.path, path module).
- Avoid hardcoding file separators or drive letters.
- Ensure CLI commands work in Windows environments.

### Additional Guidelines
- Refer to the appropriate file in .github/instructions/ for specific language guidelines.