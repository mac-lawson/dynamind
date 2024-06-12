![excali](/docs/excali.svg)

# Dynamind: Distributed Machine Learning

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/mac-lawson/dynamind/elixir.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/mac-lawson/dynamind)
![Hex.pm Version](https://img.shields.io/hexpm/v/axon)
[TODO and Contributing Guide](dev.md)

-------------------
This project aims to develop a distributed cognitive agent system using Elixir, capable of dynamic resource allocation in complex environments.

## Overview
Dynamind uses Erlang and Elixir to empower distributed computing for machine learning models and applications/users relying on them.  


## Getting Started
1. Clone this repository.
2. Install Elixir and Mix if not already installed.
3. Navigate to the project directory and run `mix deps.get` to install dependencies.

### Staging your project directories and nodes for production.
1. Open the `config.dynm`
2. Add your nodes under the 'nodes key' & any directories containing files under the 'projdir key'. 

```yaml
- nodes
one@localhost

- projdir
lib/sample_models/*.ex


```

### Preparing Elixir Modules
##### Prepare your module for upload
1. Ensure your module returns the proper work requirement. 
The Dynamind work requirement is a user-defined atom that **must** be returned by every function in your module. We do not calculate the computational requirements of the functions in your module, therefore you must provide this information. Work requirements are extremely subjective based on the scale of your project and the importance of the module you are uploading.


| Work Requirement     | Description                                                                                          |
|----------------------|------------------------------------------------------------------------------------------------------|
| :one                 | Simple tasks, IO, basic math                                                                         |
| :two                 | Larger simple tasks, more complex math                                                               |
| :three               | CPU work and things of the sort; something that begins to require computational intensity           |
| :four                | Work that will require a significant spike in node resources and requires dedicated resources.       |
| :five                | The main "work-horses" of your module. Modules that require *at a minimum* one or even more dedicated nodes when the task runs.  |

Below is a sample function. As you can see, the spec defines that a work requirement will be returned. 
```elixir
defmodule SampleModels.Tensor do
  @spec make_a_tensor() :: {any(), any(), Tasking.work_specs()}
  def make_a_tensor do
    t = Nx.tensor([[1, 2], [3, 4]])
    {x, y} = Nx.shape(t)
    {x, y, :one}
  end
```
When your module is in-processed through your module processing engine, the work requirement will be extracted and used to determine the stage and node that it will be paired with.

#### Non-Elixir files, models, and other resources
*Coming Soon*

## Managing your Elixir Installation
Your system and ALL NODES must be running the same version of Elixir. Most of this project's dependencies require Elixir .11 or higher, and running multiple clusters with different versions of Elixir will cause issues.

## Large Language Models
This project is designed to support large language models, such as GPT-2 and LLaMa, and other models that require significant computational resources. 

I've written/working on writing a few sample LLMs for your edification in the [sample models](/lib/sample_models) directory. 

Dynamind works great with Lua, due to the ease of use with the [luerl](github.com/rvirding/luerl) library. Because of this, I'm currently trying to port GPT-2 to Lua. You can view the progress or contribute to [llm.lua](/lib/sample_models/llm.lua) in the sample_models directory.

## Database
### Local Sqlite3

### Turso Setup

**Use the Turso CLI to get the following information about your instance**
`turso db show <db-name> --http-url` (and add /v2/pipeline)

`turso db tokens create <db-name>`

**Add the following environment variables into your system:**

- `TURSO_DB_HOST`
- `TURSO_DB_TOKEN`

You can do this by executing (for each variable):
```bash
export VAR_NAME="value"
```

## Usage
TODO: Add usage instructions once the system is developed.

## Contributing
We welcome contributions from the community! Please refer to the DEV.md file for technical information and guidelines.

## License
This project is licensed under the [MIT License](LICENSE).
