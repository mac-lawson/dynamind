![excali](/docs/excali.svg)

# Dynamind: Distributed Machine Learning

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/mac-lawson/dynamind/elixir.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/mac-lawson/dynamind)
![Hex.pm Version](https://img.shields.io/hexpm/v/axon)

-------------------
This project aims to develop a distributed cognitive agent system using Elixir, capable of dynamic resource allocation in complex environments.

## Overview
Dynamind uses Erlang and Elixir to empower distributed computing for machine learning models and applications/users relying on them.  


## Getting Started
1. Clone this repository.
2. Install Elixir and Mix if not already installed.
3. Navigate to the project directory and run `mix deps.get` to install dependencies.
4. Run `mix run -e "Dynamind.init()"`

### Setup your NODES
1. Open the `config.dynm`
2. From the basic installation there will be three example hosts already in the file. **Delete these**.
3. Add the hosts, *one per line*, that you want to connect to.

### Add your MODULES

## Managing your Elixir Installation
Your system and ALL NODES must be running the same version of Elixir. Most of this project's dependencies require Elixir .11 or higher, and running multiple clusters with different versions of Elixir will cause issues.

## Large Language Models
This project is designed to support large language models, such as GPT-2 and LLaMa, and other models that require significant computational resources. 

I've written/working on writing a few sample LLMs for your edification in the [sample models](/lib/sample_models) directory. 

Dynamind works great with Lua, due to the ease of use with the [luerl](github.com/rvirding/luerl) library. Because of this, I'm currently trying to port GPT-2 to Lua. You can view the progress or contribute to [llm.lua](/lib/sample_models/llm.lua) in the sample_models directory.


## Usage
TODO: Add usage instructions once the system is developed.

## Contributing
We welcome contributions from the community! Please refer to the DEV.md file for technical information and guidelines.

## License
This project is licensed under the [MIT License](LICENSE).
