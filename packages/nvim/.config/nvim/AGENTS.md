# Repository Guidelines

## Project Structure & Module Organization
- `init.lua`: Bootstraps Lazy.nvim and loads config.
- `lua/config/`: Core modules — `lazy.lua` (plugin setup), `options.lua`, `keymaps.lua`, `autocmds.lua`.
- `lua/plugins/*.lua`: Plugin specs and settings grouped per plugin.
- `lazy-lock.json`: Locked plugin versions. Commit when updating plugins.
- `stylua.toml`: Lua formatting rules for this repo.
- `.neoconf.json`: Optional Neovim/LSP settings.
- `README.md`, `avante.md`: High‑level docs and agent notes.
- `mcpservers.json`: MCP server config. Do not commit secrets.

## Build, Test, and Development Commands
- Run config: `nvim`
- Plugins: `:Lazy sync` (install/update), `:Lazy update`, `:Lazy clean`, `:Lazy check`
- Tooling: `:Mason` (LSP/DAP/tools), `:checkhealth`, `:TSUpdate`
- Headless install: `nvim --headless '+Lazy! sync' +qa`
- Format Lua: `stylua .` (check-only: `stylua --check .`)

## Coding Style & Naming Conventions
- Indentation: 2 spaces; wrap at 120 columns (see `stylua.toml`).
- Lua modules: return tables; avoid global state; prefer `require`-scoped config.
- File names: lowercase; mirror plugin names (e.g., `nvim-lspconfig.lua`, `telescope.lua`).
- Keep user options in `lua/config/*`; plugin-specific tweaks live under `lua/plugins/*`.

## Testing Guidelines
- No automated tests. Validate by launching `nvim` and running `:checkhealth`.
- Ensure clean startup (no errors) and expected behavior of changed plugins/features.
- For reproducible installs, run `nvim --headless '+Lazy! sync' +qa` before testing.

## Commit & Pull Request Guidelines
- Use imperative, concise messages. Conventional Commits preferred: `feat: …`, `fix: …`, `chore: …`.
- Scope examples: `feat(telescope): add live_grep args`; `fix(lsp): disable spell`.
- PRs must include: summary, rationale, before/after notes or screenshots (if visual), test steps (`:Lazy sync`, commands run), and linked issues.

## Security & Configuration Tips
- Never commit tokens or private endpoints (see `mcpservers.json`). Use env vars or local files in `.gitignore`.
- For isolated experiments, duplicate this config under a different app name and run with `NVIM_APPNAME=nvim-dev nvim`.

