# Set the console keyboard layout

The default [console keymap](https://wiki.archlinux.org/title/Console_keymap) is [US](https://en.wikipedia.org/wiki/File:KB_United_States-NoAltGr.svg). Available layouts can be listed with:
```bash
ls /usr/share/kbd/keymaps/**/*.map.gz
```
To set the keyboard layout, pass a corresponding file name to [loadkeys(1)](https://man.archlinux.org/man/loadkeys.1), omitting path and file extension. For example, to set a [German](https://en.wikipedia.org/wiki/File:KB_Germany.svg) keyboard layout:
```bash
loadkeys de-latin1
```
[Console fonts](https://wiki.archlinux.org/title/Console_fonts) are located in /usr/share/kbd/consolefonts/ and can likewise be set with [setfont(8)](https://man.archlinux.org/man/setfont.8).

# Verify the boot mode
To verify the boot mode, list the [efivars](https://wiki.archlinux.org/title/Efivars) directory:
```bash
ls /sys/firmware/efi/efivars
```

















