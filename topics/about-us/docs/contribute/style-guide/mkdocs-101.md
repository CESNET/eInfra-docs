# MkDocs 101

This section describes the essentials of markup language allowing you to write a simple page.
Only the most basic elements are described here to give you a general idea of the workflow.
For more information, see [mkdocs-material][a].

## Headers

```
# Header 1
## Header 2
Up to #### Header 4
```

## Text

Formatting:

```
*italics*
**bold**
```

One `enter` acts as space, blank line breaks the text into paragraph.

## Lists

Indentation: 4 spaces

Bullets point symbols `*` or `–` for unordered list.

Ordered list start with number, can be the same number, MkDocs will translate it, e.g.:

```
1. entry1
1. entry2
1. entry3
```

Will automatically translate to

```
1. entry1
2. entry2
3. entry3
```

## Tables

```
| First Header | Second Header | Third Header |
| ------------ | ------------- | ------------ |
| Content Cell | Content Cell  | Content Cell |
| Content Cell | Content Cell  | Content Cell |
```

Aligning columns to left/center/right is done by placing `:` characters at the beginning and/or end of the divider:

```
| Left align   |  Center align  |  Right align |
| :----------- | :------------: | -----------: |
| Content      |     Content    |      Content |
```

## Code blocks

Starts and ends with three backticks `\``.
You can specify the environment/language (console in the example below) at the beginning. But not necessary.

\```console
Some code
In code block
\```

Word marked with single `\`` from both sides creates `code formatting` inline.

## Admonitions

Start with `!!!`. Text is indented with 4 spaces. Can add title of the admonition using `“`, for example:

!!! Note “Alternative text”
    This is a note admonition.

Most often we use `Note`, `Tip`, `Important`, and `Warning` admonitions. (But less is more.)

## Links

Writing simply www.address.com translates as plaintext in MkDocs. So a reference is required.
For links, we use reference ID, for example:

`[www.address.com][a]` or `[see this section][1]`

And then put the reference link at the end of the file:

```
[a]: www.address.com
[1]: https://docs.it4i.cz/dice/
```

We usually use alphabet for links outside the docs and numerals for links inside the docs.
Links inside the docs can be relative.

## Images

We don’t use reference ID for images. So for example:

```
![](../img/image.png)
```

can be added in the text to show the respective image at that place.

Empty `[]` means there is no alternative text for the image.

[a]: https://squidfunk.github.io/mkdocs-material/reference/
