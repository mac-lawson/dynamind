defmodule Environment.Modfinder do
  @spec get_modules(String.t()) :: [module()]
  def get_modules(file_path) do
    # file_path = "lib/sample_models/tensor.ex"
    file_path = file_path

    app_dir = File.cwd!()
    absolute_file_path = Path.join([app_dir, file_path])

    {:ok, contents} = File.read(absolute_file_path)

    # \S is equivalent to [^\s]
    pattern = ~r{defmodule \s+ (\S+) }x

    Regex.scan(pattern, contents, capture: :all_but_first)
    |> Enum.map(fn [name] ->
      String.to_existing_atom("Elixir.#{name}")
    end)
  end
end
