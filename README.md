# ColorAssetGen

## Installation
### Makefile
```sh
$ git clone git@github.com:t-osawa-009/ColorAssetGen.git
$ cd ColorAssetGen
$ make install
```

### [Mint](https://github.com/yonaskolb/Mint)
```sh
$ brew install mint
$ mint install t-osawa-009/ColorAssetGen
```

## Usage
1. Prepare the original data, Localizable.strings.
```json
[
    {
      "colorName": "test",
      "hex": "#33a1de",
      "hex_dark_color": "#9d5c7f",
      "hex_light_color": "#9d5c7f",
    },
]

```

2. Execute the command.
```sh
$ ColorAssetGen --output_path Assets.xcassets --json_path Color.json 
```

3. The Assets.xcassets file is generated.

## CONTRIBUTING
- There's still a lot of work to do here. We would love to see you involved. You can find all the details on how to get started in the Contributing Guide.

## License
ColorAssetGen is released under the MIT license. See LICENSE for details.
