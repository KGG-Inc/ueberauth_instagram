defmodule Ueberauth.Strategy.Instagram.OAuth do
  @moduledoc """
  OAuth2 for Instagram.

  Add `:client_id` and `:client_secret` to your configuration:

      config :ueberauth, Ueberauth.Strategy.Instagram.OAuth,
        client_id: System.get_env("INSTAGRAM_APP_iD"),
        client_secret: System.get_env("INSTAGRAM_APP_SECRET")

  """
  use OAuth2.Strategy
https://api.instagram.com/oauth/authorize
  @defaults [
    strategy: __MODULE__,
    site: "https://api.instagram.com",
    authorize_url: "https://api.instagram.com/oauth/authorize",
    token_url: "/oauth/access_token",
    token_method: :post
  ]

  @doc """
  Construct a client for requests to Instagram.

  This will be setup automatically for you in `Ueberauth.Strategy.Instagram`.
  These options are only useful for usage outside the normal callback phase
  of Ueberauth.
  """
  def client(opts \\ []) do
    config = Application.get_env(:ueberauth, Ueberauth.Strategy.Instagram.OAuth, [])

    opts =
      @defaults
      |> Keyword.merge(config)
      |> Keyword.merge(opts)

    json_library = Ueberauth.json_library()

    opts
    |> OAuth2.Client.new()
    |> OAuth2.Client.put_serializer("application/json", json_library)
  end

  @doc """
  Provides the authorize url for the request phase of Ueberauth.
  No need to call this usually.
  """
  def authorize_url!(params \\ [], opts \\ []) do
    opts
    |> client
    |> OAuth2.Client.authorize_url!(params)
  end

  def get_token!(params \\ [], opts \\ []) do
    opts
    |> client
    |> OAuth2.Client.get_token!(params)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
