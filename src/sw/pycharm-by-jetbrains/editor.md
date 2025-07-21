# Software / PyCharm (by JetBrains) / Editor

TODO

## How-tos

### Find and replace text

#### Find and replace text using regex

- Click the `.*` button to enable Regex "mode".
- Reference the captured groups in the "Replace with" field using `$1`, `$2`, etc.
- Use `$0` to reference the entire string matched by the pattern.

Example: to replace all occurrences of the substring `, index=1, level=2`, where the values
change but must be an integer, with the substring `, level=2, index=1`, and keeping the values:

- find regex: `, index=(\d+), level=(\d+)`
- replace regex: `, level=$2, index=$1`

As a result, the text `, index=1, level=2` will be replaced with `, level=2, index=1`.

More info:
[PyCharm Documentation / Find and replace text using regular expressions](https://www.jetbrains.com/help/pycharm/tutorial-finding-and-replacing-text-using-regular-expressions.html)
