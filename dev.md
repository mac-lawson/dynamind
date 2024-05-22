# Dynamind Technical Manual
*version 1b*
*By Mac Lawson*

### Tasks

*These are in order by relative importance.*

| Title | Module(s) Involved | Work Required |
| --------------- | --------------- | --------------- |
| **Module-Function Pairing** | env/tasking | Function to map functions and nodes from both DBs |
| **Module-Function Execution** | env/tasking | Might need to a new sub-folder to be created. Once pairing is completed, do the actual work. |
| User Process Objection | env/tasking | Some sort of system in the config or during processing to allow user to mark/object to a method in a module to being ran. |
| TCP Client | agent | A lot. TCP client and server for managing sending data on non-Elixir programs |
| Database Viewer | utils | Finish the ASCII tables and finalize the getter functions. |
| Non-Elixir File Processing **MAJOR** | import directory | This is a two part problem: 1, develop a solution to process what functions ARE inside of the non-elixir modules. 2, figure out a way to convert these over too something that can be run in Elixir.  |




#### TCP Client

TCP client should be used if you have a node that either can not run Elixir OR needs to run a non-Elixir model.

TCP Server -> File To Run -> TCP Client -> Dynamind



