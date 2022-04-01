# Überauth Instagram

[![Build Status](https://travis-ci.org/ueberauth/ueberauth_instagram.svg?branch=master)](https://travis-ci.org/ueberauth/ueberauth_instagram)
[![Module Version](https://img.shields.io/hexpm/v/ueberauth_instagram.svg)](https://hex.pm/packages/ueberauth_instagram)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ueberauth_instagram/)
[![Total Download](https://img.shields.io/hexpm/dt/ueberauth_instagram.svg)](https://hex.pm/packages/ueberauth_instagram)
[![License](https://img.shields.io/hexpm/l/ueberauth_instagram.svg)](https://github.com/ueberauth/ueberauth_instagram/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/ueberauth/ueberauth_instagram.svg)](https://github.com/ueberauth/ueberauth_instagram/commits/master)

> Instagram OAuth2 strategy for Überauth.

## Installation

1. Setup your application at [Instagram Developers](https://developers.Instagram.com).

1. Add `:ueberauth_instagram` to your list of dependencies in `mix.exs`:

   ```elixir
   def deps do
     [
       {:ueberauth_instagram, "~> 0.8"}
     ]
   end
   ```

1. Add the strategy to your applications:

   ```elixir
   def application do
     [
       applications: [:ueberauth_instagram]
     ]
   end
   ```

1. Add Instagram to your Überauth configuration:

   ```elixir
   config :ueberauth, Ueberauth,
     providers: [
       Instagram: {Ueberauth.Strategy.Instagram, []}
     ]
   ```

1. Update your provider configuration:

   ```elixir
   config :ueberauth, Ueberauth.Strategy.Instagram.OAuth,
     client_id: System.get_env("INSTAGRAM_CLIENT_iD"),
     client_secret: System.get_env("INSTAGRAM_CLIENT_SECRET")
   ```

1. Include the Überauth plug in your controller:

   ```elixir
   defmodule MyApp.AuthController do
     use MyApp.Web, :controller
     plug Ueberauth
     ...
   end
   ```

1. Create the request and callback routes if you haven't already:

   ```elixir
   scope "/auth", MyApp do
     pipe_through :browser

     get "/:provider", AuthController, :request
     get "/:provider/callback", AuthController, :callback
   end
   ```

1. Your controller needs to implement callbacks to deal with `Ueberauth.Auth` and `Ueberauth.Failure` responses.

For an example implementation see the [Überauth Example](https://github.com/ueberauth/ueberauth_example) application.

## Calling

Depending on the configured URL you can initialize the request through:

    /auth/Instagram

Or with options (`auth_type`, `scope`, `locale`, `display`):

    /auth/Instagram?scope=email,public_profile

By default the requested scope is "public_profile". Scope can be configured either explicitly as a `scope` query value on the request path or in your configuration:

```elixir
config :ueberauth, Ueberauth,
  providers: [
    Instagram: {Ueberauth.Strategy.Instagram, [default_scope: "email,public_profile,user_friends"]}
  ]
```

Additionally you can now specify the `display` param to pass to Instagram:

```elixir
config :ueberauth, Ueberauth,
  providers: [
    Instagram: {Ueberauth.Strategy.Instagram, [
      default_scope: "email,public_profile,user_friends",
      display: "popup"
    ]}
  ]
```

`display` can be the following values: `page` (default), `async`, `iframe`, `popup`, `touch`, `wap`

Starting with Graph API version 2.4, Instagram has limited the default fields returned when fetching the user profile.
Fields can be explicitly requested using the `profile_fields` option:

```elixir
config :ueberauth, Ueberauth,
  providers: [
    Instagram: {Ueberauth.Strategy.Instagram, [profile_fields: "name,email,first_name,last_name"]}
  ]
```

See [Graph API Reference > User](https://developers.instagram.com/docs/graph-api/reference/user) for full list of fields.

## Copyright and License

Copyright (c) 2015 Sean Callan

Released under the MIT License, which can be found in the repository in [LICENSE](./LICENSE).
