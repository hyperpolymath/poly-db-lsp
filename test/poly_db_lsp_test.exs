# SPDX-License-Identifier: PMPL-1.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>

defmodule PolyDB.LSPTest do
  use ExUnit.Case
  doctest PolyDB.LSP

  test "detect_databases returns list of detected databases" do
    # This would need a real project path with database configs
    assert {:ok, detected} = PolyDB.LSP.detect_databases(".")
    assert is_list(detected)
  end

  test "list_adapters returns metadata for all adapters" do
    adapters = PolyDB.LSP.list_adapters()
    assert is_list(adapters)
    assert length(adapters) == 6  # Currently implemented

    # Check each adapter has required metadata fields
    Enum.each(adapters, fn adapter ->
      assert Map.has_key?(adapter, :name)
      assert Map.has_key?(adapter, :type)
      assert Map.has_key?(adapter, :description)
      assert Map.has_key?(adapter, :cli_tool)
      assert Map.has_key?(adapter, :default_port)
      assert Map.has_key?(adapter, :config_files)
    end)
  end
end
