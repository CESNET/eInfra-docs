# Best Practices for Writing Doc

This section contains conventions and best practices for writing the best possible documentation.

!!! note
    The section is work in progress.

## Style Guide

Below, you can find notes and recommendations on how to contribute to the documentation.

### General Information & Recommendations

* Use American English.
* Use active voice, short sentences, and short paragraphs.
* Aim for short sections/subsections.
* Aim for well-structured text –⁠ use headings, lists, admonitions, etc.

### Text
 
* **Abbreviations and acronyms**
    * Spell them out the first time and add the abbreviation/acronym into brackets.
* **Data**
    * Treat the noun as singular, i.e. *Data is...*.
* **Email**
    * Use non-hyphenated version, i.e. **not** e-mail.
* **Gender**
    * If the gender is unknown, use neutral *they*.
* **Heading**
    * Each word start with a capital letter, except for very short prepositions.
    * If it's not a standard word, e.g. e-INFRA CZ, it must be included in the `.spelling` file.
* **Link**
    * The text of a link should indicate where it leads, e.g. *see section 2* instead of *see here*.
    * Avoid using long URLs as link text.
    * For email addresses, spell out the address and link it.
* **List**
    * Short list/enumeration entries start with bullet point, end without punctuation.
    * Entries in a list following incomplete sentence start with a lower case letter and end with a semicolon. Last entry ends with a full stop.
* **Numbers**
    * Spell out the numbers from one to ten.
* **Oxford comma**
    * Put a comma before the last element in a list before the coordinating conjunction,
  such as *and* or *or* in a series of three or more terms,
  e.g. *The e-INFRA CZ research infrastructure is being built in cooperation between CERIT-SC, CESNET, and IT4I.*
  
### Images

* **Size**
  * Don't use abnormally large images unless required for legibility.
  * Use descriptive name for an image.
  * Use images in the `png` format.

## Authoring and responsibility

Each topic has responsible department or person which will be responsible for approving changes.

| Area      | Responsible                          |
| ----------- | ------------------------------------ |
| Homepage, navigation, general site       | @rosinec, Jan Siwiec |
| Accounts      | Pavel Zlamal |
| Data processing    | @rosinec |
| Data storage    | du.cesnet.cz |
| Managed Data Services | @rosinec |
| General Information    | @rosinec, Jan Siwiec |

## Passing Test in Doc Build

Each pipeline starts with four test jobs:

1. **capitalize** - checks capitalization of (sub)titles. Every word should start with a capital letter except for prepositions. Specific words with mixed lower- and uppercase letters (e.g. eINFRA) should be added as exceptions to the *.spelling* file.

1. **docs** - checks some standard rules of formatting to make the source code more "readable".
The most frequently occuring errors being: **trailing spaces** (i.e. multiple spaces at the EOL), **consecutive blank lines** or,
alternatively, **missing blank lines** (each element -- admonition, codeblock, (sub)title, image link, etc. -- must be divided by a blank line).
For the list of most frequent check fails, see the List of checks section.

1. **pylint** - don't know, but always passes :)

1. **pysafety** - related to missing security update for the tornado package, always fails (is allowed to fail)

## Contribution and Revision Process

TODO. Here we should write down some processess for revisions and merging requests for change.
