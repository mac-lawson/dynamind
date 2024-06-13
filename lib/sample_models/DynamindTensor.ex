defmodule DynamindTensor do
  @moduledoc """
  A container for multidimensional data structures.

  `DynamindTensor` has the following fields:

    * `:data` - the tensor data
    * `:shape` - the tensor shape
    * `:type` - the tensor type
    * `:names` - the tensor names
    * `:vectorized_axes` - a tuple that encodes names and sizes for vectorization

  It is discouraged to access these fields directly. Use the provided functions instead.
  """

  @type data :: any()
  @type type :: any()
  @type shape :: tuple()
  @type axis :: name | integer
  @type axes :: [axis]
  @type name :: atom

  @type t :: %DynamindTensor{data: data, type: type, shape: shape, names: [name]}
  @type t(data) :: %DynamindTensor{data: data, type: type, shape: shape, names: [name]}

  @enforce_keys [:type, :shape, :names]
  defstruct [:data, :type, :shape, :names, vectorized_axes: []]

  ## Access

  def fetch(%DynamindTensor{shape: {}} = tensor, _index) do
    raise ArgumentError,
          "cannot use the tensor[index] syntax on scalar tensor #{inspect(tensor)}"
  end

  def fetch(tensor, index) when is_integer(index),
    do: {:ok, fetch_axes(tensor, [{0, index}])}

  def fetch(tensor, _.._//_ = range),
    do: {:ok, fetch_axes(tensor, [{0, range}])}

  def fetch(tensor, []),
    do: {:ok, tensor}

  def fetch(%{names: names} = tensor, [{_, _} | _] = keyword),
    do: {:ok, fetch_axes(tensor, with_names(keyword, names, []))}

  def fetch(tensor, [_ | _] = list),
    do: {:ok, fetch_axes(tensor, with_index(list, 0, []))}

  def fetch(_tensor, value) do
    raise ArgumentError, "Invalid index: #{inspect(value)}"
  end

  defp with_index([h | t], i, acc), do: with_index(t, i + 1, [{i, h} | acc])
  defp with_index([], _i, acc), do: acc

  defp with_names([], _names, acc), do: acc

  defp fetch_axes(%DynamindTensor{shape: shape} = tensor, axes) do
    rank = tuple_size(shape)
    {start, lengths, squeeze, strides} = fetch_axes(rank - 1, axes, shape, [], [], [], [])
    tensor |> slice(start, lengths, strides) |> squeeze(axes)
  end

  defp fetch_axes(axis, axes, shape, start, lengths, squeeze, strides) when axis >= 0 do
    case List.keytake(axes, axis, 0) do
      {{^axis, index}, axes} when is_integer(index) ->
        index = normalize_index(index, axis, shape)

        fetch_axes(axis - 1, axes, shape, [index | start], [1 | lengths], [axis | squeeze], [
          1 | strides
        ])

      {{^axis, first..last_in//step}, axes} ->
        first = normalize_index(first, axis, shape)
        last = normalize_index(last_in, axis, shape)
        range = first..last//step
        len = abs(last - first) + 1

        fetch_axes(axis - 1, axes, shape, [first | start], [len | lengths], squeeze, [
          step | strides
        ])

      nil ->
        fetch_axes(axis - 1, axes, shape, [0 | start], [elem(shape, axis) | lengths], squeeze, [
          1 | strides
        ])
    end
  end

  defp fetch_axes(_axis, [], _shape, start, lengths, squeeze, strides),
    do: {start, lengths, squeeze, strides}

  defp normalize_index(index, axis, shape) do
    dim = elem(shape, axis)
    norm = if index < 0, do: dim + index, else: index
    if norm < 0 or norm >= dim, do: raise("index out of bounds")
  end

  # Dummy implementation
  def slice(tensor, start, lengths, strides), do: %DynamindTensor{tensor | data: :sliced}
  # Dummy implementation
  def squeeze(tensor, axes), do: tensor

  defimpl Inspect do
    import Inspect.Algebra

    def inspect(
          %DynamindTensor{
            shape: shape,
            names: names,
            type: type,
            vectorized_axes: vectorized_axes
          } = tensor,
          opts
        ) do
      open = color("[", :list, opts)
      close = color("]", :list, opts)
      type = color(inspect(type), :atom, opts)
      shape = to_algebra(shape, names, open, close)
      vectorized_shape = to_algebra(vectorized_axes, [], open, close)
      # Placeholder
      data = "data"

      concat([
        color("#DynamindTensor<", :map, opts),
        nest(concat([line(), vectorized_shape, type, shape, line(), data]), 2),
        line(),
        color(">", :map, opts)
      ])
    end

    defp to_algebra(shape, names, open, close),
      do: concat([open, Enum.join(Tuple.to_list(shape), ", "), close])
  end
end
