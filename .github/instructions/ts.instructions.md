---
applyTo: '**/*.ts'
---
# TypeScript Coding Best Practices

## TypeScript-Specific Guidelines
- Prefer `const` and `let` over `var` for variable declarations.
- Use type annotations for function parameters, return types, and variables.
- Prefer interfaces over type aliases for object shapes.
- Avoid using `any`; use specific types or generics where possible.
- Use ES6+ features and syntax.

## Formatting
- Use semicolons consistently.
- Use single quotes for strings, except when escaping is easier with double quotes.

## Error Handling
- Use try/catch blocks for asynchronous code and handle errors gracefully.
- Avoid using bare `catch` clauses; specify the error type if possible.

## Documentation
- Add JSDoc comments to all public classes, interfaces, functions, and methods.

## Testing
- Write unit tests for all functions and classes.
- Use frameworks like Jest or Mocha.
- Name test files and functions clearly.

## File and Directory Structure
- Use lowercase with hyphens for file and folder names.
- Organize code into modules and folders logically.
- Place executable code inside `main` or entry-point files.

## Performance
- Profile and optimize only after identifying bottlenecks.
- Use built-in data structures and libraries where possible.

## Version Control
- Commit code with clear, concise messages.
- Do not commit secrets or large binary files.