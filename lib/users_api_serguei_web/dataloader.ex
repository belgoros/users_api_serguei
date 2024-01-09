defmodule UsersApiSergueiWeb.Dataloader do
  @moduledoc false
  
  alias UsersApiSerguei.Accounts

  def dataloader, do: Dataloader.new() |> Dataloader.add_source(Accounts, Accounts.data())
end
