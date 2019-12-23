defmodule Mix.Tasks.Pab.Setup do
  @moduledoc """
  This is used to finish new project setup, include rename module and files

  ## Usage
  wip

  ## Options
  * `--module`, `-m` set project module name

  ## Example
  """
  use Mix.Task

  @shortdoc "phx api boilerplate setup task"

  @orig_module_name "PhxApiBoilerplate"
  @orig_project_name "phx_api_boilerplate"

  @scan_paths ~w[./lib/** ./priv/** ./test/** ./config/** mix.exs README.md .env.example .gitignore]
  @exclude_files ~w[lib/mix/tasks/pab.setup.ex]

  def run(all_args) do
    {opts, args, _} =
      OptionParser.parse(all_args, switches: [module: :string], aliases: [m: :module])

    try do
      case Keyword.get(opts, :module) do
        nil -> nil
        any -> true = String.starts_with?(any, String.first(any) |> String.upcase())
      end
    rescue
      _ ->
        reraise(
          ArgumentError,
          "the first character of the module name must be capitalized",
          __STACKTRACE__
        )
    end

    target_project_name =
      List.first(args) || raise(ArgumentError, "project name must provided") |> String.downcase()

    target_module_name =
      Keyword.get(opts, :module) ||
        String.split(target_project_name, "_") |> Enum.map_join("", &String.capitalize(&1))

    paths = scan_files()
    rename_module(paths, target_module_name)
    rename_module(paths, target_project_name, @orig_project_name)
    rename_project(paths, target_project_name)
  end

  defp rename_project(paths, targ, orig \\ @orig_project_name) do
    Mix.shell().info("rename project from #{orig} to #{targ}")

    paths = Enum.sort_by(paths, &String.length/1, &>=/2)

    for path <- paths do
      p = Path.split(path)
      last_p = List.last(p)

      if String.contains?(last_p, orig) do
        try do
          path_tail = last_p |> String.replace(orig, targ)
          targ_path = List.delete_at(p, -1) |> List.insert_at(-1, path_tail) |> Path.join()
          File.rename!(path, targ_path)
        rescue
          _ -> Mix.shell().info("rename project failed at #{path}")
        end
      end
    end
  end

  defp rename_module(paths, targ, orig \\ @orig_module_name) do
    Mix.shell().info("rename module from #{orig} to #{targ}")

    for p <- paths do
      unless File.dir?(p) or Enum.member?(@exclude_files, p) do
        contents =
          File.stream!(p)
          |> Enum.map(&String.replace(&1, orig, targ))
          |> Enum.join("")

        File.write!(p, contents)
      end
    end
  end

  defp scan_files() do
    c =
      for path <- @scan_paths do
        Path.wildcard(path)
      end

    List.flatten(c)
  end
end
