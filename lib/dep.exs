defmodule Dep do
  def load() do
      Code.require_file("lib/utils/reqdeps.exs")
      ReqDeps.pull()
  end
end
