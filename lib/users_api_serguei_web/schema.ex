defmodule UsersApiSergueiWeb.Schema do
  use Absinthe.Schema
  alias UsersApiSergueiWeb.Dataloader

  import_types(UsersApiSergueiWeb.Graphql.Queries.UserQueries)

  import_types(UsersApiSergueiWeb.Graphql.Types.UserType)
  import_types(UsersApiSergueiWeb.Graphql.Types.PreferenceType)

  import_types(UsersApiSergueiWeb.Graphql.InputTypes.PreferenceInput)

  import_types(UsersApiSergueiWeb.Graphql.Mutations.UserMutation)
  import_types(UsersApiSergueiWeb.Graphql.Mutations.PreferenceMutation)

  import_types(UsersApiSergueiWeb.Graphql.Subscriptions.CreateUserSubscription)
  import_types(UsersApiSergueiWeb.Graphql.Subscriptions.UpdateUserPreferencesSubscription)

  def context(ctx), do: Map.put(ctx, :loader, Dataloader.dataloader())

  def plugins, do: [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:update_preference_mutation)
    import_fields(:create_user_mutation)
    import_fields(:update_user_mutation)
  end

  subscription do
    import_fields(:new_user_subscription)
    import_fields(:update_user_preferences_subscription)
  end
end
