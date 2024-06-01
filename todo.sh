#!/bin/bash

FILE="todo.txt"

create_task() {

    echo "Enter task ID:"
    read id
    while [[ -z $id ]]; do
    	echo "Task ID cannot be empty. Please enter the ID." >&2
	read id
    done

    echo "Enter task title (required):"
    read title
    while [[ -z $title ]]; do
	echo "Title cannot be empty. Please enter Title." >&2
	read title
    done

    echo "Enter task description:"
    read description

    echo "Enter task location:"
    read location

    echo "Enter task due date and time (DD-MM-YYYY HH-MM):"
    read date_time

    while [[ -z $date_time ]]; do
	echo "Due Date and Time cannot be empty. Please enter them." >&2
	read date_time
    done

    echo "Enter completion status (0 for incomplete, 1 for complete):"
    read completed

    echo "ID:$id|$title|$description|$location|$date_time|$completed" >> "$FILE"
    echo "Task created successfully."
}

update_task() {
	echo "Enter the ID of the task to update."
	read id_to_update
	while [[ -z $id_to_update ]]; do
		echo "Please enter a valid ID for a task to update."
		read id_to_update
	done
	while ! grep -q "ID:$id_to_update" $FILE; do
		echo "No Task with this ID exists. Please enter a valid one."
		read id_to_update
	done

	echo "Task Found!"

	echo "Enter the new task title (required):"
        read title
        while [[ -z $title ]]; do
        	echo "Title cannot be empty. Please enter Title." >&2
        	read title
        done

	echo "Enter the new  task description:"
        read description

        echo "Enter the new task location:"
        read location

        echo "Enter the new task due date and time (DD-MM-YYYY HH-MM):"
        read date_time

	while [[ -z $date_time ]]; do
        	echo "Due Date and Time cannot be empty. Please enter them." >&2
        	read date_time
        done

        echo "Enter the new completion status (0 for incomplete, 1 for complete):"
        read completed

	sed -i "/ID:$id_to_update/c\ID:$id_to_update|$title|$description|$location|$date_time|$completed" $FILE
	echo "Task updated successfully."
}

delete_task() {

	echo "Enter the ID of the task to delete."
        read id_to_delete
        while [[ -z $id_to_delete ]]; do
                echo "Please enter a valid ID for a task to delete."
                read id_to_update
        done
        while ! grep -q "ID:$id_to_delete" $FILE; do
                echo "No Task with this ID exists. Please enter a valid one."
                read id_to_update
        done
	sed -i "/ID:$id_to_delete/d" $FILE
	echo "Task with id $id_to_delete has been successfully deleted."
}

show_task() {

	echo "Enter the ID of the task to show."
        read id_to_show
        while [[ -z $id_to_show ]]; do
                echo "Please enter a valid ID for a task to show."
                read id_to_show
        done
        while ! grep -q "ID:$id_to_show" $FILE; do
                echo "No Task with this ID exists. Please enter a valid one."
                read id_to_show
        done

	id=$(grep "ID:$id_to_show" $FILE | awk -F '|' '{print $1}')
	title=$(grep "ID:$id_to_show" $FILE | awk -F '|' '{print $2}')
	desc=$(grep "ID:$id_to_show" $FILE | awk -F '|' '{print $3}')
	loc=$(grep "ID:$id_to_show" $FILE | awk -F '|' '{print $4}')
	date_time=$(grep "ID:$id_to_show" $FILE | awk -F '|' '{print $5}')
	completed=$(grep "ID:$id_to_show" $FILE | awk -F '|' '{print $6}')
	echo "$id"
	echo "Title is: $title"
	echo "Description is: $desc"
	echo "Location is: $loc"
	echo "Date and Time are: $date_time"
	echo "Completion is: $completed (0=uncompleted, 1=completed)"
}

show_task_by_day() {

	echo "Enter the Date you want to list the tasks by (DD:MM:YYYY):"
	read day
	while [[ -z $day ]]; do
                echo "Please enter a valid Date to show the tasks."
                read day
        done
        while ! grep -q "$day" $FILE; do
                echo "This date doesnt exist in the databse or is not valid date. Please enter a valid one."
                read day
        done
	
}

search_by_title() {

	echo "Enter the Title of the task you want to search for:"
        read title_search
        while [[ -z $title_search ]]; do
                echo "Please enter a valid Title."
                read title_search
        done
        while ! grep -q "|$title_search|" $FILE; do
                echo "No tasks with this Title."
                read title_search
        done

	id=$(grep "|$title_search|" $FILE | awk -F '|' '{print $1}')
        title=$(grep "|$title_search|" $FILE | awk -F '|' '{print $2}')
        desc=$(grep "|$title_search|" $FILE | awk -F '|' '{print $3}')
        loc=$(grep "|$title_search|" $FILE | awk -F '|' '{print $4}')
        date_time=$(grep "|$title_search|" $FILE | awk -F '|' '{print $5}')
        completed=$(grep "|$title_search|" $FILE | awk -F '|' '{print $6}')

	echo "Task found. Here are its details:"
	echo "$id"
        echo "Title is: $title"
        echo "Description is: $desc"
        echo "Location is: $loc"
        echo "Date and Time are: $date_time"
        echo "Completion is: $completed (0=uncompleted, 1=completed)"
}

showall() {

	current_date=$(date +%d-%m-%Y)
	grep "$current_date" "$FILE"

}

help() {

	echo -e "This is the help section of the todo.sh script.\n	./todo.sh addtask : Prompts the user to enter the details of a new task.\n	./todo.sh update : Prompts the user to enter the new info of the task to update.\n	./todo.sh delete : Prompts the user to enter the id of the task to delete.\n	./todo.sh show : Prompts the user to enter the id of the task to show the info for.\n	./todo.sh showbyday : Will show the tasks of the current day."
	echo -e "	./todo.sh searchbytitle : Prompts the user to enter a title to look for a corresponding task.\n	  ./todo.sh help : Displays the help menu for the todo.sh script.\n	./todo.sh (no arguments) : Displays the tasks of the current day."

}

if [[ "$1" == "addtask" ]]; then
	create_task
elif [[ "$1" == "update" ]]; then
	update_task
elif [[ "$1" == "delete" ]]; then
	delete_task
elif [[ "$1" == "show" ]]; then
	show_task
elif [[ "$1" == "showbyday" ]]; then
	show_task_by_day
elif [[ "$1" == "searchbytitle" ]]; then
	search_by_title
elif [[ $# -eq 0 ]]; then
	showall
elif [[ "$1" == "help" ]]; then
	help
fi
