
# IP Change Notifier

This project is a simple utility written in Go, used for detecting public IP changes in your network. It communicates with `ipinfo.io` API to get the public IP information. Whenever the network interface or the public IP changes, the utility updates its state, which is stored in a local TOML file.

## Installation

You can install the IP Change Notifier by cloning the repository and then running:

```
go build -o ipchange
```

This command will build an executable named `ipchange`.

## Usage

To run the IP Change Notifier, use the following command:

```
./ipchange
```

The utility does not take any command-line arguments. All configurations are managed through the `config.toml` file.

## Configuration

The IP Change Notifier uses two TOML files located in the `.local/ipchange` directory under the user's home directory:

- `config.toml`: Stores the API configuration details:
  - `Token`: Your `ipinfo.io` access token.
  - `URL`: The `ipinfo.io` API URL.
- `storage.toml`: Stores the application's state data.

Example `config.toml`:

```
Token = "your_ipinfo_io_token"
URL = "https://ipinfo.io"
```

## Output

The utility outputs a JSON object to stdout containing:

- `last_time_check`: The time of the last check in RFC3339 format.
- `public_ip`: The last known public IP address.
- `ip_changed`: A boolean that indicates whether the IP has changed since the last check.

## Dependencies

This utility uses the following dependencies:

- [pelletier/go-toml](https://github.com/pelletier/go-toml): Used to parse and marshal TOML files.

## Contributing

Please feel free to open an issue or a pull request if you want to contribute to this project!

## License

This project is licensed under the MIT License.