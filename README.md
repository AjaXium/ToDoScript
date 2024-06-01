Todo is a task management script.

Tasks are stored in this format:
        id|title|description|location|dateandtime|completedstatus

The code is structred using functions, each option has its own function that is called based on the arguments passed.

This is how you can operate the script:

        ./todo.sh addtask : Prompts the user to enter the details of a new task.
        ./todo.sh update : Prompts the user to enter the new info of the task t>
        ./todo.sh delete : Prompts the user to enter the id of the task to dele>
        ./todo.sh show : Prompts the user to enter the id of the task to show t>
        ./todo.sh showbyday : Will show the tasks of the current day.
        ./todo.sh searchbytitle : Prompts the user to enter a title to look for>
        ./todo.sh help : Displays the help menu for the todo.sh script.
        ./todo.sh (no arguments) : Displays the tasks of the current day.
