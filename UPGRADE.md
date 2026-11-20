# Development tooling upgrade

Keep the Neovim version that already supports your Treesitter main configuration (verify with `nvim --version` and `:checkhealth`), Git, Node.js, Yarn for JS projects, and the existing ripgrep/fd/build tools. On macOS install or retain the Xcode command-line tools.

After applying the patch, close Octo/Diffview reviews safely and restart Neovim. Run `:Lazy install` (rather than updating every existing plugin), then `:MasonInstall clang-format stylua js-debug-adapter codelldb`. The LSP allowlist also installs clangd. Restart after installation; commit the resulting `lazy-lock.json`.

## New and changed shortcuts

| Shortcut | Action |
| --- | --- |
| `gt` / `gT` | Next / previous tab (native) |
| `Space t]` / `Space t[` | Next / previous tab (alternative) |
| `Ctrl+i` / `Ctrl+o` | Forward / backward in jump history |
| `Space ef` | Focus Neo-tree |
| `Space fg`, then `Ctrl+Space` | Case-insensitive grep, then fuzzy refine |
| `Space ci` | Go to implementation |
| `Space cy` | Go to type definition |
| `Space db` / `Space dB` | Toggle breakpoint / conditional breakpoint |
| `Space dc` | Start or continue debugger |
| `Space di` / `Space do` / `Space dO` | Step into / over / out |
| `Space du` / `Space de` / `Space dr` | Debug UI / evaluate / REPL |
| `Space dt` | Terminate debug session |
| `Space td` | Debug nearest Jest test |
| `Space jr` | Select task |
| `Space jt` | Toggle task list |
| `Space js` | Enter a shell command as a task |
| `Space jp` | Run current playground script, or prompt for a script name |
| `Space xx` / `Space xe` / `Space xb` | All diagnostics / errors / buffer diagnostics |
| `Space xs` / `Space xr` / `Space xq` | Symbols / LSP locations / Quickfix |
| `[m` / `]m` | Previous / next function start |
| `[M` / `]M` | Previous / next function end |
| `vaf` / `vif` | Select function / body |
| `yaf` / `daf` / `cif` | Yank function / delete function / change body |
| `vac` / `vic` / `via` | Class / class body / parameter |
| `Space ch` | Toggle sticky Treesitter context |
| `Space cf` | Format with Prettier, clang-format or StyLua |

## Debugging

For a project-specific Node/TypeScript command, start your existing runner with its Node inspector enabled on localhost port 9229. For example, for an ordinary JS entry point: `node --inspect-brk=127.0.0.1:9229 index.js`. Do not pass `yarn` as a JavaScript file to `node`. For scripts launched through Yarn/ts-node, configure the actual Node child process with the inspector and source maps; avoid setting an inspector flag globally on multiple competing Node processes. Set breakpoints, press `Space dc`, select the inspector attach configuration, then continue. The direct launch preset is intentionally restricted to JavaScript. For Jest use `Space td` from inside a test; the pinned Jest adapter uses `pwa-node`, but launching via Yarn may need project-specific debugger settings. Project-specific source maps, Yarn PnP and child processes may require adapter configuration.

For CMake projects, build a debug binary and generate a compilation database:

```sh
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build
```

With source open, press `Space dc` and select the executable under `build/`. Clangd can find compile_commands.json in a build directory in common setups; if needed configure `--compile-commands-dir` or provide a symlink at the project root.

## Checks

- Open a TS file and inspect `:checkhealth vim.lsp`; only `tsc` and optionally ESLint should attach.
- `:ConformInfo` in C++, Lua, and TS files.
- `:checkhealth nvim-treesitter`, `:checkhealth telescope`, `:checkhealth dap`.
- Run `:Lazy profile` to inspect startup time.
- `:OverseerShell yarn --version` is a harmless task-runner smoke test.

The existing theme, Octo custom navigation, review shortcuts, Neo-tree behavior and scoped playground Telescope searches are preserved. `Tab` / `Shift+Tab` no longer change native tabs, deliberately avoiding interference with Ctrl+i. Save your playground buffer before running it. The task mapping assumes `yarn playground <script>` and locates the `tarpon` package from the Git root; adjust if your launcher uses different arguments. No project files are modified by the configuration patch itself. The new tool adapters require local installation and runtime verification.
