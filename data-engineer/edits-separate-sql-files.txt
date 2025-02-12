Generate separate .sql files for the database `sample-db-create.sql`

## First, analyze deeply
Analyze the relationship between the tables using `sample-db-schema.png` before generating any .sql file.

## File output rules
- Output into a new `/sample-outputs/sql-files` folder
- Create sub folders for each object category. For example, when generating the table object SQL files, place them into the `../tables/` (`/sample-outputs/sql-files/tables/`) folder.
- Create 1 file per object (i.e. one file per table and 1 file per stored procedure).
- Ensure that all generated files follow naming conventions and are consistently formatted.