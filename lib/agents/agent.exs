defmodule AgentMan do
  @moduledoc """
  Module containing the definition of a cognitive agent.
  """

  defstruct [:id, :name, :state, :ip_hostname, :user]

  @doc """
  Creates a new agent with the given ID and name.
  """
  def new(id, name, ip_or_hostname, username) do
    %__MODULE__{id: id, name: name, state: %{}, ip_hostname: ip_or_hostname, user: username}
  end

  @doc """
  Retrieves the ID of the agent.
  """
  def get_id(agent) do
    agent.id
  end

  @doc """
  Retrieves the name of the agent.
  """
  def get_name(agent) do
    agent.name
  end

  @doc """
  Retrieves the current state of the agent.
  """
  def get_state(agent) do
    agent.state
  end

  @doc """
  Updates the state of the agent.
  """
  def update_state(agent, new_state) do
    %__MODULE__{agent | state: new_state}
  end

  @doc """
  Performs an action based on the agent's current state.
  """
  def perform_action(agent) do
    # Implement action logic based on agent's state
    IO.puts "Agent #{agent.name} performing action..."
  end
end
