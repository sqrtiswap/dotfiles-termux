# dotfiles-termux

## Requirements
The following directories are expected to exist:
- `~/storage/shared/Sync/todo`
- `~/storage/shared/Sync/todo_fist`
- `~/storage/shared/Sync/todo_uni`
- `~/storage/shared/Sync/remind`

and the following packages to be installed:
- `curl`
- `git`
- `perl`
- `remind`
- [todo](https://github.com/sqrtiswap/todo)
- `vis`

None of them are essential.
The corresponding lines can just be removed to avoid annoying error messages.

## Setup
1. Setup [shared storage](https://wiki.termux.com/wiki/Termux-setup-storage).
2. Install the [Termux:API plugin](https://wiki.termux.com/wiki/Termux:API).
3. Install the `termux-api` package: `pkg install termux-api`.
4. Setup the dotfiles: `make`.

## Removal
```shell
make uninstall
```

## License
[ISC](https://opensource.org/licenses/ISC)
