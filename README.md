     ______   _______ _________ _______ _________ _        _______  _______ 
    (  __  \ (  ___  )\__   __/(  ____ \\__   __/( \      (  ____ \(  ____ \
    | (  \  )| (   ) |   ) (   | (    \/   ) (   | (      | (    \/| (    \/
    | |   ) || |   | |   | |   | (__       | |   | |      | (__    | (_____ 
    | |   | || |   | |   | |   |  __)      | |   | |      |  __)   (_____  )
    | |   ) || |   | |   | |   | (         | |   | |      | (            ) |
    | (__/  )| (___) |   | |   | )      ___) (___| (____/\| (____/\/\____) |
    (______/ (_______)   )_(   |/       \_______/(_______/(_______/\_______)
                                                                            

My Dotfiles Project
===============

Author: Erik Lunna
Date Started: 03-13-15
Version Update (12-20-15) - Trimmed everything way down.
Version Update (11-22-16) - Restructured .vimrc - trimmed off the fat.
Version Update (11-22-16) - 
>My custom run-control files for mostly Pythonic coding in Vim. 

Summary
---------------
Designed using Linux Mint 17.3, Free to copy/revise/refactor any of the contents herewithin.

Make File
-----------------
Included is a simple make file to aid in setup. The default directory structure is use is:
	/home
		/Documents
			/dotfiles

If you would rather have your dotfiles in /home/dotfiles, simply change it in make.sh. 

Currently I'm covering:
~/.bashrc
~/.git-completion.bash
~/.NERDTreeBookmarks
~/.nethackrc
~/.vimrc

.bashrc
-----------------
This contains a bunch of useful aliases and functions for the Linux/Python developer.

.custom_aliases and .custom_functions are auto-added to your home directory for your own personal stuff. They are auto-sourced by .bashrc.

"Todo List"
-----------------
Manage todo items in Vim using 2 files in the /dotfiles/todo directory. (todo.txt and completed.txt)

Each task must only be 1 line of text.

* todolist.txt: Add tasks by writing "todo:" followed by the item. 
* completed.txt: Contains a list of tasks that have been completed.

To mark a todo item as Done: Move your cursor to the line of the todo, and hit <Leader><Leader>d (in my setup that translates to ,,d) This will cut the task, replace the "todo" with "done" and ship the task to the
completed file.  It even prepends the date completed to the beginning!


