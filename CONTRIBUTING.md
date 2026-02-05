# Contributing to poly-db-lsp

Thank you for considering contributing to poly-db-lsp!

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/poly-db-lsp`
3. Install dependencies: `just deps`
4. Run tests: `just test`

## Development Workflow

### Adding a New Database Adapter

1. Create a new file in `lib/adapters/` (e.g., `lib/adapters/elasticsearch.ex`)
2. Implement the `PolyDB.Adapters.Behaviour` callbacks:
   - `detect/1` - Detect if database is configured
   - `query/2` - Execute queries
   - `schema/1` - Retrieve schema information
   - `migrate/2` - Run migrations
   - `backup/2` - Create backups
   - `version/0` - Get database version
   - `metadata/0` - Return adapter metadata

3. Add the adapter to the supervision tree in `lib/poly_db_lsp/application.ex`
4. Update `PolyDB.LSP` module to include the new adapter
5. Write tests in `test/adapters/`

### Example Adapter Structure

```elixir
defmodule PolyDB.Adapters.YourDatabase do
  use GenServer
  @behaviour PolyDB.Adapters.Behaviour

  require Logger

  # Client API
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl PolyDB.Adapters.Behaviour
  def detect(project_path) do
    # Check for config files
    {:ok, config_exists?}
  end

  @impl PolyDB.Adapters.Behaviour
  def query(connection_info, query_string) do
    GenServer.call(__MODULE__, {:query, connection_info, query_string})
  end

  # Implement remaining callbacks...

  # Server callbacks
  @impl true
  def init(_opts) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:query, connection_info, query}, _from, state) do
    # Execute query using CLI tool
    {:reply, {:ok, result}, state}
  end
end
```

## Code Quality

Before submitting a PR:

```bash
just quality    # Run all quality checks
just test       # Run tests
```

### Standards

- Follow the Elixir style guide
- Add documentation for all public functions
- Include tests for new features
- Update CHANGELOG.md

## Pull Request Process

1. Update the README.adoc if adding new features
2. Update CHANGELOG.md under "Unreleased"
3. Ensure all tests pass
4. Update documentation as needed
5. Submit PR with clear description

## Code of Conduct

Be respectful and professional in all interactions.

## License

By contributing, you agree that your contributions will be licensed under PMPL-1.0-or-later.
