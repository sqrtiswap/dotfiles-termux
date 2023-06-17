# dotfiles-termux

## Setup
1. Install the [Termux:API plugin](https://wiki.termux.com/wiki/Termux:API)
2. Install the `termux-api` package: `pkg install termux-api`
3. Setup the dotfiles: `make`

Expectations:
- todo(1) files are synchronised to `~/storage/shared/Sync/todo`
- remind(1) files are synchronised to `~/storage/shared/Sync/remind`

## Removal
```shell
make uninstall
```

## License
[ISC](https://opensource.org/licenses/ISC)
