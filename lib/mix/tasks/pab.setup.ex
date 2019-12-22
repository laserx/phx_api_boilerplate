defmodule Mix.Tasks.Pab.Setup do
  @moduledoc """
  This is used to finish new project setup, include rename module and files
  """
  use Mix.Task

  @shortdoc "phx api boilerplate setup task"

  def run(all_args) do
    {opts, args, _} =
      OptionParser.parse(all_args, switches: [module: :string], aliases: [m: :module])

    try do
      c = Keyword.get(opts, :module)
      ^c = String.capitalize(opts[:module])
    rescue
      _ -> raise ArgumentError, "module name must use Upcase"
    end

    folder_name =
      List.first(args) || raise(ArgumentError, "project name must provided") |> String.downcase()

    IO.inspect([folder_name, opts])
  end
end
