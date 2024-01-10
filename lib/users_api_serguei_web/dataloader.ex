defmodule UsersApiSergueiWeb.Dataloader do
  @moduledoc false

  alias UsersApiSerguei.Accounts

  def dataloader, do:  Dataloader.add_source(Dataloader.new(), Accounts, Accounts.data())
end
