# pass-type

A pass extension for « typing » instead of copy/pasting

## Usage

```
Usage:

    pass type pass-name
    Simulate typing of your password 3seconds after the decode.
```

## Installation

- Enable password-store extensions by setting PASSWORD_STORE_ENABLE_EXTENSIONS=true
- copy type.bash in ~/password-store/.extensions

## Example

```shell
$ PASSWORD_STORE_ENABLE_EXTENSIONS=true pass type perso/demo
The password will be type in 3 seconds
[… 3 seconds later]
$ SUPER SECURE PASSWORD
```

## Requirements

- ```pass``` 1.7.0 or later for extension support
- ```xdotools``` for Linux

## Contribution

Contributions are always welcome.