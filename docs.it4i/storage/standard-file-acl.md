# Standard File ACL

Access control list (ACL) provides an additional, more flexible permission mechanism for file systems. It is designed to assist with UNIX file permissions. ACL allows you to give permissions for any user or group to any disk resource.

## Show ACL

To show permissions, use:

```code
$ getfacl <file/dir>
```

### Examples

Set all permissions for user john to file named testfile:

```code
$ setfacl -m "u:john:rwx" testfile
```

Check permissions:

```code
$ getfacl testfile
# file: testfile
# owner: someone
# group: someone
user::rw-
user:john:rwx
group::r--
mask::rwx
other::r--
```

Change permissions for user john:

```code
$ setfacl -m "u:john:r-x" testfile
```

Check permissions:

```code
$ getfacl testfile
# file: testfile
# owner: someone
# group: someone
user::rw-
user:john:r-x
group::r--
mask::r-x
other::r--
```

Remove all ACL entries:

```code
$ setfacl -b testfile
```

Check permissions:

```code
$ getfacl testfile
# file: testfile
# owner: someone
# group: someone
user::rw-
group::r--
other::r--
```

## Output of LS Command

You will notice that there is an ACL for a given file because it will exhibit `+`  after its Unix permissions in the output of `ls -l`.

```code
$ ls -l testfile
crw-rw----+ 1 someone someone 14, 4 nov.   9 12:49 testfile
```

## Modify ACL

The ACL can be modified using the `setfacl` command.

You can list file/directory permission changes without modifying the permissions (i.e. dry-run) by appending the `--test` flag.
To apply operations to all files and directories recursively, append the `-R/--recursive` argument.

To set permissions for a user (user is either the user name or ID):

```code
$ setfacl -m "u:user:permissions" <file/dir>
```

To set permissions for a group (group is either the group name or ID):

```code
$ setfacl -m "g:group:permissions" <file/dir>
```

To set permissions for others:

```code
$ setfacl -m "other:permissions" <file/dir>
```

To allow all newly created files or directories to inherit entries from the parent directory (this will not affect files which will be copied into the directory):

```code
$ setfacl -dm "entry" <dir>
```

To remove a specific entry:

```code
$ setfacl -x "entry" <file/dir>
```

To remove the default entries:

```code
$ setfacl -k <file/dir>
```

To remove all entries (entries of the owner, group and others are retained):

```code
$ setfacl -b <file/dir>
```

Source: [wiki.archlinux.org][1]

[1]: https://wiki.archlinux.org/title/Access_Control_Lists
