[agent-instructions](../prompt-snippets/agent-instructions.md)

Generate SQL statements for Postgres database.
The schema of this database is found in this [diagram](/data-engineer/sample-db-schema.png) file.
For additional reference, the database schema backup is also scripted in this [SQL file](/data-engineer/sample-db-create.sql).

Before generating SQL statements:
- Understand the relationship between the tables in the database.
- Determine the filtering criteria and conditions for data retrieval.
- Validate the expected outcome of the query.
- Think step-by-step and revalidate before responding.

## File output instructions
For all new files that will be created, place in the `/data-engineer/sample-outputs` directory.