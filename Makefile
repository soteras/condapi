deps_get:
	mix deps.get

format:
	mix format

credo:
	mix credo

ci:
	mix format --check-formatted
	mix credo --strict
	mix test