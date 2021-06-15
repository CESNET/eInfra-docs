# NFSv4 File ACL

An NFSv4 ACL consists of one or more NFSv4 ACEs (Access Control Entry), each delimited by a comma or whitespace.

An NFSv4 ACE is written as a colon-delimited, 4-field string in the following format:

``` code
<type>:<flags>:<principal>:<permissions>
```

## ACE Elements

`<type>` - one of:

| Flag | Name  |
| ---- | ----- |
| A    | allow |
| D    | deny  |
| U    | audit |
| L    | alarm |

`<flags>` - zero or more (depending on `<type>`) of:

| Flag | Name                                        |
| ---- | ------------------------------------------- |
| f    | file-inherit                                |
| d    | directory-inherit                           |
| p    | no-propagate-inherit                        |
| i    | inherit-only                                |
| S    | successful-access                           |
| F    | failed-access                               |
| g    | group (denotes that <principal> is a group) |

`<principal>` - named user or group, or one of: `OWNER@`, `GROUP@`, `EVERYONE@`

`<permissions>` - one or more of:

| Flag | Name                              |
| ---- | --------------------------------- |
| r    | read-data / list-directory        |
| w    | write-data / create-file          |
| a    | append-data / create-subdirectory |
| x    | execute                           |
| d    | delete                            |
| D    | delete-child (directories only)   |
| t    | read-attrs                        |
| T    | write-attrs                       |
| n    | read-named-attrs                  |
| N    | write-named-attrs                 |
| c    | read-ACL                          |
| C    | write-ACL                         |
| o    | write-owner                       |
| y    | synchronize                       |

## Example

``` code
[root@login2.salomon proj1]# nfs4_getfacl open-20-11

# file: open-20-11
A::OWNER@:rwaDxtTcCy
A::GROUP@:rxtcy
A:g:open-20-11@it4i.cz:rwaDxtcy
A::EVERYONE@:tcy
A:fdi:OWNER@:rwaDxtTcCy
A:fdi:GROUP@:rxtcy
A:fdig:open-20-11@it4i.cz:rwaDxtcy
A:fdi:EVERYONE@:tcy
```
