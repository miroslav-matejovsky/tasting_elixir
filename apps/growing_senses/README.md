# GrowingSenses

Start application with

```powershell
iex.bat -S mix
```

Then in the `iex` shell, start the logger:

```elixir
GrowingSenses.reset_counter()
GrowingSenses.change_message("Custom log message")
```
