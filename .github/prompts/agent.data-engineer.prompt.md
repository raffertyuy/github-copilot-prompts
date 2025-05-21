[agent-instructions](../prompt-snippets/agent-instructions.md)

Generate SQL statements for Postgres database. Before generating
- understand the relationship between the tables in the database by referring to this [database schema](/docs/postgres-db/dvdrental-dbschema.png).
- Validate the names and datatypes by checking this [SQL file](/docs/postgres-db/dvdrental-dbschema.sql).

Before generating SQL statements:
- Understand the relationship between the tables in the database.
- Determine the filtering criteria and conditions for data retrieval.
- Validate the expected outcome of the query.
- Think step-by-step and revalidate before responding.

## File output instructions
For all new files that will be created, place in the `/sample-outputs` directory.