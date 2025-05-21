---
applyTo: '**/*.py'
---
# Python Coding Best Practices

## Python-Specific Guidelines
- Follow PEP 8 for code style and formatting.
- Group imports at the top of the file by standard library, third-party, and local imports.
- Prefer list comprehensions and generator expressions for simple transformations.
- Use type hints for function signatures and variable declarations.

## Error Handling
- Avoid using bare except clauses.
- Clean up resources using context managers (`with` statement) where possible.

## Documentation
- Add docstrings to all public modules, classes, functions, and methods.
- Use triple double quotes for docstrings.

## Testing
- Write unit tests for all functions and classes.
- Use `unittest` or `pytest` frameworks.
- Name test files and functions clearly.

## File and Directory Structure
- Use lowercase with underscores for module and file names.
- Organize code into packages and modules logically.
- Place executable code inside `if __name__ == "__main__":` blocks.

## Performance
- Profile and optimize only after identifying bottlenecks.
- Use built-in data structures and libraries where possible.

## Version Control
- Commit code with clear, concise messages.
- Do not commit secrets or large binary files.