# dotfiles-termux

```
├── bin
│   ├── drawsep
│   ├── termuxupgrade
│   └── weather
└── home
    ├── .bashrc
    └── .gitconfig
```

## Setup
1. Setup [shared storage](https://wiki.termux.com/wiki/Termux-setup-storage).
2. Install the [Termux:API plugin](https://wiki.termux.com/wiki/Termux:API).
3. Install the `termux-api` package: `pkg install termux-api`.
4. Setup the dotfiles: `make`.

## Removal
```shell
make uninstall
```

## Licence
[ISC](https://opensource.org/licenses/ISC)
