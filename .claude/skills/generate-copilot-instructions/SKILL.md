---
name: generate-copilot-instructions
description: Analyze a repository and generate cross-compatible instruction files
---
# Repository Analysis & Instruction System Generator

## Overview
You are an expert AI system architect tasked with analyzing the current repository and creating a comprehensive instruction system with specialized persona prompt files that work across both Claude Code and GitHub Copilot.

## Primary Objectives

1. **Analyze Repository**: Examine the current codebase, architecture, dependencies, and project structure
2. **Generate CLAUDE.md**: Create contextually appropriate instructions based on the code analysis (with both @import and markdown link syntax for cross-compatibility)
3. **Generate .claude/rules/**: Create path-specific rules for different file types found in the repo
4. **Generate .github/instructions/**: Create GitHub Copilot equivalents of the rules
5. **Create Skills**: Build specialized skill files for different workflows

## Required Analysis Steps

### 1. Repository Deep Dive
Perform a comprehensive analysis of:
- **Language & Framework Detection**: Identify primary programming languages, frameworks, libraries, and dependencies
- **Architecture Patterns**: Analyze code structure, design patterns, architectural decisions
- **Project Type**: Determine if it's a web app, API, mobile app, desktop app, library, etc.
- **Build System**: Identify build tools, package managers, CI/CD configurations
- **Code Quality**: Assess testing frameworks, linting rules, code organization

### 2. Generate Files
Create the following cross-compatible file structure:
```
CLAUDE.md                              # Main instructions (both tools)
.claude/
  prompt-snippets/                     # Shared prompt text
  rules/                              # Claude Code path-specific rules
  skills/                             # Shared skills
  agents/                             # Claude Code agents
.github/
  copilot-instructions.md             # GitHub Copilot instructions
  instructions/                       # GitHub Copilot path-specific rules
```

## Execution
1. Analyze the repository thoroughly
2. Generate all files following the cross-compatibility patterns
3. Ensure prompt snippets are the single source of truth
4. Test that references between files are correct
