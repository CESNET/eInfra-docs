# List of Rules

Below is an excerpt from the list of rules, what they are checking for,
as well as an examples of documents that break the rule and corrected
versions of the examples.
The rules mentioned here represent 99% of failed check in our documentation.
For a detailed list of the rules, see [https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md][1]

## MD004 - Unordered List Style

This rule is triggered when the symbols used in the document for unordered
list items do not match the configured unordered list style:

    * Item 1
    + Item 2
    - Item 3

To fix this issue, use the configured style for list items throughout the
document:

    * Item 1
    * Item 2
    * Item 3

Note: the configured list style can be a specific symbol to use (asterisk,
plus, dash), or simply require that the usage be consistent within the
document (consistent) or within a level (sublist).

For sublist, each level must be consistent within a document, even if they
are separate lists. So this is allowed:

    * Item 1
    * Item 2
      - Item 2a
        + Item 2a1
      - Item 2b
    * Item 3

    Other stuff

    * Item 1
    * Item 2

But this is not allowed:

    * Item 1
    * Item 2
      - Item 2a
        + Item 2a1
      - Item 2b
    * Item 3

    Other stuff

    - Item 1
    - Item 2

## MD005 - Inconsistent Indentation for List Items at Same Level

This rule is triggered when list items are parsed as being at the same level,
but don't have the same indentation:

    * Item 1
        * Nested Item 1
        * Nested Item 2
       * A misaligned item

Usually this rule will be triggered because of a typo. Correct the indentation
for the list to fix it:

    * Item 1
      * Nested Item 1
      * Nested Item 2
      * Nested Item 3

## MD006 - Consider Starting Bulleted Lists at the Beginning of the Line

This rule is triggered when top level lists don't start at the beginning of a
line:

    Some text

      * List item
      * List item

To fix, ensure that top level list items are not indented:


    Some test

    * List item
    * List item

## MD007 - Unordered List Indentation

This rule is triggered when list items are not indented by the configured
number of spaces.

Example:

    * List item
       * Nested list item indented by 3 spaces

Corrected Example:

    * List item
      * Nested list item indented by 2 spaces

## MD009 - Trailing Spaces

This rule is triggered on any lines that end with whitespace. To fix this,
find the line that is triggered and remove any trailing spaces from the end.

## MD011 - Reversed Link Syntax

This rule is triggered when text that appears to be a link is encountered, but
where the syntax appears to have been reversed (the `[]` and `()` are
reversed):

    (Incorrect link syntax)[http://www.example.com/]

To fix this, swap the `[]` and `()` around:

    [Correct link syntax](http://www.example.com/)

## MD012 - Multiple Consecutive Blank Bines

This rule is triggered when there are multiple consecutive blank lines in the
document:

    Some text here


    Some more text here

To fix this, delete the offending lines:

    Some text here

    Some more text here

Note: this rule will not be triggered if there are multiple consecutive blank
lines inside code blocks.

## MD022 - Headers Should Be Surrounded by Blank Lines

This rule is triggered when headers (any style) are either not preceded or not
followed by a blank line:

    # Header 1
    Some text

    Some more text
    ## Header 2

To fix this, ensure that all headers have a blank line both before and after
(except where the header is at the beginning or end of the document):

    # Header 1

    Some text

    Some more text

    ## Header 2

## MD025 - Multiple Top Level Headers in the Same Document

This rule is triggered when a top level header is in use (the first line of
the file is a h1 header), and more than one h1 header is in use in the
document:

    # Top level header

    # Another top level header

To fix, structure your document so that there is a single h1 header that is
the title for the document, and all later headers are h2 or lower level
headers:

    # Title

    ## Header

    ## Another header

## MD026 - Trailing Punctuation in Header

This rule is triggered on any header that has a punctuation character as the
last character in the line:

    # This is a header.

To fix this, remove any trailing punctuation:

    # This is a header

## MD031 - Fenced Code Blocks Should Be Surrounded by Blank Lines

This rule is triggered when fenced code blocks are either not preceded or not
followed by a blank line:

    Some text
    ```
    Code block
    ```

    ```
    Another code block
    ```
    Some more text

To fix this, ensure that all fenced code blocks have a blank line both before
and after (except where the block is at the beginning or end of the document):

    Some text

    ```
    Code block
    ```

    ```
    Another code block
    ```

    Some more text

## MD032 - Lists Should Be Surrounded by Blank Lines

Tags: bullet, ul, ol, blank_lines

Aliases: blanks-around-lists

This rule is triggered when lists (of any kind) are either not preceded or not
followed by a blank line:

    Some text
    * Some
    * List

    1. Some
    2. List
    Some text

To fix this, ensure that all lists have a blank line both before and after
(except where the block is at the beginning or end of the document):

    Some text

    * Some
    * List

    1. Some
    2. List

    Some text

## MD033 - Inline HTML

Tags: html

Aliases: no-inline-html

This rule is triggered whenever raw HTML is used in a markdown document:

    <h1>Inline HTML header</h1>

To fix this, use 'pure' markdown instead of including raw HTML:

    # Markdown header

## MD034 - Bare URL Used

This rule is triggered whenever a URL is given that isn't surrounded by angle
brackets:

    For more information, see http://www.example.com/.

To fix this, add angle brackets around the URL:

    For more information, see <http://www.example.com/>.

## MD037 - Spaces Inside Emphasis Markers

This rule is triggered when emphasis markers (bold, italic) are used, but they
have spaces between the markers and the text:

    Here is some ** bold ** text.

    Here is some * italic * text.

    Here is some more __ bold __ text.

    Here is some more _ italic _ text.

To fix this, remove the spaces around the emphasis markers:

    Here is some **bold** text.

    Here is some *italic* text.

    Here is some more __bold__ text.

    Here is some more _italic_ text.

## MD038 - Spaces Inside Code Span Elements

This rule is triggered on code span elements that have spaces right inside the
backticks:

    ` some text `

    `some text `

    ` some text`

To fix this, remove the spaces inside the codespan markers:

    `some text`

## MD039 - Spaces Inside Link Text

This rule is triggered on links that have spaces surrounding the link text:

    [ a link ](http://www.example.com/)

To fix this, remove the spaces surrounding the link text:

    [a link](http://www.example.com/)

[1]: https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md
