# conjur-logging-cookbook

This cookbook is DEPRECATED.

Use https://github.com/conjur-cookbooks/conjur instead.

Log shipping on Conjur-managed hosts.

## Supported Platforms

1. Ubuntu 13.10

## Attributes

<!--<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['conjur-logging']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>-->

## Usage

### conjur-logging::default

Include `conjur-logging` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[conjur-logging::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Rafal Rzepecki (rafal@conjur.net)
