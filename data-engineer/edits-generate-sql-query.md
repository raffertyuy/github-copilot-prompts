## Instructions
- Use Copilot Edits
- Reference the prompt `data-engineer.prompt.md`
- Toggle Agent mode

This ensures that GitHub Copilot refers to the DB Schema (in png and sql files)

## Running and Troubleshooting
1. Open PG Admin and connect to the database
2. Run the generated SQL statement after each prompt.
3. If the SQL statement is not working, type
    ```
    The SQL statement is not working, this is the error message:
    {copy-paste the error message}
    ```

## Prompts
1. generate a query for all customers joined with their address. output the name, city and country of the customer.
2. separate first_name and last_name columns. Also add a columns for the total # of films the customer has rented.
3. add two more new columns: "top_film_category" which is the film category count that the customer has rented the most, and ""top_film_category_count" which is the # of films the customer has rented in that top film category.

## Extra (New Session) - Use a CSV output of the output from #3 above.
```
Generate a new python notebook `output-notebook.ipynb`. This notebook should read the `sample-query-output.csv` and create a graph that shows the top film category by country.

Use the root folder `/data-engineer/sample-outputs` for all outputs.
If running a CLI command, ensure that you are in this directory first.
- Check that you are in this specified root folder directory.
- If not, switch to this directory.
Also generate a new `requirements.txt` file for all the dependencies required, including `pandas`, `matplotlib`, and any other necessary packages.
Create a new virtual environment called `venv` using `python -m venv venv` and install the dependencies from the `requirements.txt` file by running `pip install -r requirements.txt`.
Make sure to activate the virtual environment before running the installations.
```

Troubleshoot output as needed.