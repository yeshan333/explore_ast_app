# ExploreAstApp

> A plug app for exploring ast.

> Source Code Ref:
> - https://elixirschool.com/en/lessons/misc/plug
> - https://dev.to/mpevec9/understanding-elixir-plug-o77

## Get Deps

```shell
HEX_MIRROR=https://cdn.jsdelivr.net/hex mix deps.get
```

## Start Service (DEV-env)

```shell
mix run --no-halt
```

## Run Tests

```shell
mix test
```

```shell
# Get unit test coverage
mix coveralls.html
```

## Build App

```shell
MIX_ENV=prod mix distillery.release
```
