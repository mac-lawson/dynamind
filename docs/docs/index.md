# Dynamind
####  A distributed cognitive agent system capable of dynamic resource allocation in complex environments. 

## Change Log
* Beta v0.2 - First documentation release
* Beta v0.1 - Initial release

## Project layout & readers guide
If you are not familiar with the way Elixir Mix projects are organized, please take a look at [this](https://elixirforum.com/t/what-directory-structure-and-files-does-mix-create/11031) Elixir forum post.

Below is a brief orientation of the project layout. Not every folder is included, but all the primary folders are.

    src/    # Contains C and Rust connectors to outside services, such as the ESP32 microcontroller and the Turso remote database mirror. 
    lib/    # The primary Elixir source code.
        db  # Database related code.
        environment   # Other markdown pages, images and other files.
